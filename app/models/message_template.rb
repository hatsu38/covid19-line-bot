class MessageTemplate
  MY_AREA_SETTING = {
    "type": "template",
    "altText": "自分の地域を設定",
    "template": {
      "type": "buttons",
      "actions": [
        {
          "type": "message",
          "label": "キャンセル",
          "text": "キャンセル"
        }
      ],
      "text": "自分の地域を設定します。\nどこの地域の感染者数を知りたいですか？\n\n入力例）東京都, 北海道, 福岡県など"
    }
  }.freeze

  REMIND_TIME_SETTING = {
    "type": "template",
    "altText": "通知時間を設定",
    "template": {
      "type": "buttons",
      "actions": [
        {
          "type": "message",
          "label": "キャンセル",
          "text": "キャンセル"
        }
      ],
      "text": "感染者数をお知らせする時間を設定します。\n\n入力例）7:00, 10:00, 19:00など"
    }
  }.freeze
end
