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
      "text": "自分の地域を設定します。\nどこの地域の感染者数を知りたいですか？\n入力例）東京都, 北海道, 福岡県 など"
    }
  }.freeze
end
