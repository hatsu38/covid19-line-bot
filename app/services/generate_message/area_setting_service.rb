class GenerateMessage::AreaSettingService
  def execute
    {
      type: "template",
      altText: "自分の地域を設定",
      template: {
        type: "buttons",
        actions: [
          {
            type: "message",
            label: "キャンセル",
            text: "キャンセル"
          }
        ],
        title: "🚗自分の地域を設定",
        text: "お住まいの都道府県名を入力してください。\n例）東京都, 北海道, 福岡県など"
      }
    }
  end
end
