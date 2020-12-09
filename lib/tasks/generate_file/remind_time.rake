# bundle exec generate:remind_time
# リマインド時間の選択肢のymlを作成します。10分毎に設定しています。be
namespace :generate do
  desc "イベントをTwitterBotがツイート"
  task :remind_time do
    START_ID = 0
    # 10分ごとに時間分割する
    END_ID = (60 / 10 * 24) - 1

    write_text = ""
    (START_ID..END_ID).each do |id|
        text = <<-EOS
- id: #{id}
  type: oclock_#{hour_time_text(id)}#{minute_time_text(id)}
  name_24: #{hour_name_text(id)}#{minute_name_text(id)}
  name_12: #{hour_name_text_12(id)}#{minute_name_text(id)}
  name_en_12: #{hour_name_text_en_12(id)}#{minute_name_text(id)}
  time: "#{hour_time_text(id).to_s}:#{minute_time_text(id).to_s}"
  time_easy: "#{hour_time_text(id).to_s}#{minute_time_text(id).to_s}"
EOS
      write_text += text
    end

    File.open("config/divisions/remind_time.yml", mode = "w") do |f|
      f.write(write_text)  # ファイルに書き込む
    end
  end

  def hour_name_text(id)
    hour = id / 6
    "#{hour}時"
  end

  def hour_name_text_12(id)
    hour = id / 6
    hour_12 = hour > 12 ? "午後#{hour - 12}" : "午前#{hour}"
    "#{hour_12}時"
  end

  def hour_name_text_en_12(id)
    hour = id / 6
    hour_12 = hour > 12 ? "PM#{hour - 12}" : "AM#{hour}"
    "#{hour_12}時"
  end

  def minute_name_text(id)
    minute = (id % 6) * 10
    minute.zero? ? "" : "#{minute}分"
  end

  def hour_time_text(id)
    hour = id / 6
    format('%02d', hour)
  end

  def minute_time_text(id)
    minute = (id % 6) * 10
    format('%02d', minute)
  end
end