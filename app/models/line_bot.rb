class LineBot
  # rubocop:disable Metrics/AbcSize
  def self.client
    if Rails.env.production?
      Line::Bot::Client.new do |config|
        config.channel_id = Rails.application.credentials.line[:channel_id]
        config.channel_secret = Rails.application.credentials.line[:channel_secret]
        config.channel_token = Rails.application.credentials.line[:channel_token]
      end
    else
      Line::Bot::Client.new do |config|
        config.channel_id = Rails.application.credentials.dev_line[:channel_id]
        config.channel_secret = Rails.application.credentials.dev_line[:channel_secret]
        config.channel_token = Rails.application.credentials.dev_line[:channel_token]
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  def reply_text(reply_token, message)
    client.reply_message(reply_token, text_message(message))
  end

  private

  def text_message(text)
    {
      "type" => "text",
      "text" => text
    }
  end
end
