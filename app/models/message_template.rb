class MessageTemplate
  AREA_SETTING = {
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
  }.freeze

  REMIND_TIME_SETTING = {
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
      title: "⏰通知時間を設定",
      text: "通知する時間を設定してください。\n10分単位で設定可能です。\n例）0時, 10時30分, 19:50など"
    }
  }.freeze
end
