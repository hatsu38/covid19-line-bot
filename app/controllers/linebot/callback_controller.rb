class Linebot::CallbackController < ApplicationController
  protect_from_forgery

  # rubocop:disable Metrics/AbcSize
  def create
    client = LineBot.client
    body = request.body.read
    signature = request.env["HTTP_X_LINE_SIGNATURE"]

    head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Follow
        User.find_or_create_by(line_id: event["source"]["userId"])
        message = {
          type: "text",
          text: "お住まいの都道府県名を入力してください"
        }
        client.reply_message(event["replyToken"], message)
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          resent_prefecture_info = Api::Covid19.find_by(name: event.message["text"])
          message = {
            type: "text",
            text: event.message["text"] + "の累積陽性者数は#{resent_prefecture_info['npatients']}人です"
          }
          client.reply_message(event["replyToken"], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message["id"])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end
