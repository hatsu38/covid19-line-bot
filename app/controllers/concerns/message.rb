module Message
  extend ActiveSupport::Concern

  def pandemic_count(prefecture:, count:, previous_day_ratio:)
    "【😷感染者数】\n\n#{prefecture}の累積陽性者数は#{count}人です。\n前日比は#{previous_day_ratio}人です。"
  end
end
