namespace :batch do
  desc "10分ごとにLinePushを送ります"
  task remind_covid19_cnt: :environment do
    client = LineBot.client
    # ○0分にする
    time = Time.zone.now.strftime('%H:%M').chop + "0"
    remind_time = RemindTime.find_time(time)
    User.where(remind_time_id: remind_time.id).each do |user|
      resent_prefecture_info = Api::Covid19.find_by(prefecture_name: user.prefecture.name)
      message = send_text("[#{resent_prefecture_info['date']}\\n#{user.prefecture.name}の累積陽性者数は#{resent_prefecture_info['npatients']}人です")
      client.push_message(user.line_id, message)
    end
  end
end

def send_text(text)
  {
    type: "text",
    text: text
  }
end