# bundle exec batch:remind_covid19_cnt
namespace :batch do
  desc "10分ごとにLinePushを送ります"
  task remind_covid19_cnt: :environment do
    client = LineBot.client
    # ○0分にする
    time = "#{Time.zone.now.strftime('%H:%M').chop}0"
    remind_time = RemindTime.find_time(time)
    User.where(remind_time_id: remind_time.id).each do |user|
      resent_prefecture_info = Api::Covid19.find_by(prefecture_name: user.prefecture.name)
      previous_day_ratio = Api::Covid19.find_by_previous_day_ratio(prefecture_name: user.prefecture.name)
      message = send_text(
        pandemic_count(
          prefecture: user.prefecture.name,
          count: resent_prefecture_info["npatients"],
          previous_day_ratio: previous_day_ratio
        )
      )
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

def pandemic_count(prefecture:, count:, previous_day_ratio:)
  "【😷感染者数】\n\n#{prefecture}の累積陽性者数は#{count}人です。\n前日比は#{previous_day_ratio}人です。"
end
