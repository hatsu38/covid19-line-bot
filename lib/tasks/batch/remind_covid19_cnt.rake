# bundle exec batch:remind_covid19_cnt
namespace :batch do
  desc "10分ごとにLinePushを送ります"
  task remind_covid19_cnt: :environment do
    client = LineBot.client
    # ○0分にする
    time = "#{Time.zone.now.strftime('%H:%M').chop}0"
    remind_time = RemindTime.find_time(time)
    User.where(remind_time_id: remind_time.id).each do |user|
      message = GenerateMessage::Covid19CountService.execute(user.prefecture.name)
      client.push_message(user.line_id, message)
    end
  end
end


