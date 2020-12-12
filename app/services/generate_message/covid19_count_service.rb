class GenerateMessage::Covid19CountService
  def execute(prefecture_name)
    resent_prefecture_info = Api::Covid19.find_by(prefecture_name: prefecture_name)
    previous_day_ratio = Api::Covid19.find_by_previous_day_ratio(prefecture_name: prefecture_name)
    send_text(
      pandemic_count(
        prefecture: prefecture_name,
        count: resent_prefecture_info["npatients"],
        previous_day_ratio: previous_day_ratio
      )
    )
  end

  private

  def send_text(text)
    { type: "text", text: text }
  end

  def pandemic_count(prefecture:, count:, previous_day_ratio:)
    "【😷感染者数】\n\n#{prefecture}の累積陽性者数は#{count.to_s(:delimited)}人です。\n前日比は#{previous_day_ratio}人です。"
  end

  def delimited(num)
    num.to_i.to_s(:delimited)
  end
end
