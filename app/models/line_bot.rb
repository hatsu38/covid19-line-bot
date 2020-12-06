class LineBot
  def self.client
    if Rails.env.production?
      Line::Bot::Client.new { |config|
        config.channel_id = Rails.application.credentials.line[:channel_id]
        config.channel_secret = Rails.application.credentials.line[:channel_secret]
        config.channel_token = Rails.application.credentials.line[:channel_token]
      }
    else
      Line::Bot::Client.new { |config|
        config.channel_id = Rails.application.credentials.dev_line[:channel_id]
        config.channel_secret = Rails.application.credentials.dev_line[:channel_secret]
        config.channel_token = Rails.application.credentials.dev_line[:channel_token]
      }
    end
  end
end
