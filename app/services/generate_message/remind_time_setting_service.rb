class GenerateMessage::RemindTimeSettingService
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
        title: "⏰通知時間を設定",
        text: "通知する時間を設定してください。\n10分単位で設定可能です。\n例）0時, 10時30分, 19:50など"
      }
    }
  end
end
