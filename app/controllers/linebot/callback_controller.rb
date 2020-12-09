class Linebot::CallbackController < ApplicationController
  protect_from_forgery

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/BlockLength, Metrics/PerceivedComplexity
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
        message = MessageTemplate::MY_AREA_SETTING
        user.transit_to_prefecture_code_updatable!
        client.reply_message(event["replyToken"], message)
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          recive_text = recive_text(event)
          new_pref_code = JpPrefecture::Prefecture.find_code_by_name(recive_text)
          new_remind_time = RemindTime.find_time(recive_text)
          if new_pref_code && user.prefecture_code_updatable?
            ApplicationRecord.transaction { user.update_prefecture(new_pref_code) }
            message = send_text("地域を「#{user.prefecture.name}」に変更しました")
          elsif new_pref_code
            pref_name = JpPrefecture::Prefecture.find(new_pref_code)&.name
            resent_prefecture_info = Api::Covid19.find_by(prefecture_name: pref_name)
            message = send_text("#{pref_name}の累積陽性者数は#{resent_prefecture_info['npatients']}人です")
          elsif new_remind_time && user.remind_time_updatable?
            ApplicationRecord.transaction { user.update_remind_time(new_remind_time.id) }
            message = send_text("毎日「#{new_remind_time.name}」に感染者数をお知らせします")
          elsif recive_text == "キャンセル"
            user.transit_to_updated!
            message = send_text("キャンセルしました")
          elsif recive_text == "現在の感染者数"
            resent_prefecture_info = Api::Covid19.find_by(prefecture_name: user.prefecture.name)
            message = send_text("#{user.prefecture.name}の累積陽性者数は#{resent_prefecture_info['npatients']}人です")
          elsif recive_text == "自分の地域を設定"
            user.transit_to_prefecture_code_updatable!
            message = MessageTemplate::AREA_SETTING
          elsif recive_text == "通知時間を設定"
            user.transit_to_remind_time_updatable!
            message = MessageTemplate::REMIND_TIME_SETTING
          end
          client.reply_message(event["replyToken"], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message["id"])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/BlockLength, Metrics/PerceivedComplexity

  private

  def recive_text(event)
    event.message["text"]
  end

  def send_text(text)
    {
      type: "text",
      text: text
    }
  end
end
