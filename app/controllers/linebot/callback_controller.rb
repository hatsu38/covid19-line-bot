class Linebot::CallbackController < ApplicationController
  protect_from_forgery

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/BlockLength
  def create
    client = LineBot.client
    body = request.body.read
    signature = request.env["HTTP_X_LINE_SIGNATURE"]

    head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)

    events.each do |event|
      user = User.find_or_create_by(line_id: event["source"]["userId"])
      case event
      when Line::Bot::Event::Follow
        message = {
          type: "text",
          text: "お住まいの都道府県名を入力してください"
        }
        client.reply_message(event["replyToken"], message)
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case event.message["text"]
          when "現在の感染者数"
            resent_prefecture_info = Api::Covid19.find_by(prefecture_name: user.prefecture.name)
            message = {
              type: "text",
              text: user.prefecture.name + "の累積陽性者数は#{resent_prefecture_info['npatients']}人です"
            }
            client.reply_message(event["replyToken"], message)
          when "自分の地域を設定"
            message = MessageTemplate::MY_AREA_SETTING
            client.reply_message(event["replyToken"], message)
          end
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message["id"])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/BlockLength
end
