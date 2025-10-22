# frozen_string_literal: true

require_relative "slack_notifier/version"
require_relative "slack_notifier/configuration"
require_relative "slack_notifier/client"
require_relative "slack_notifier/message"
module SlackNotifier
  class << self
    # attr_writer :configuration

    def configuration=(value) # posponing the syntactic sugar for a moment
      @configuration = value
    end

    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def reset_configuration!
      self.configuration = Configuration.new
    end

    def notify(text, options = {})
      client = Client.new
      client.notify(text, options)
    end

    def success(text, fields: [])
      message = Message.success(text, fields: fields)
      notify(message.text, attachments: message.attachments)
    end

    def error(text, fields: [])
      message = Message.error(text, fields: fields)
      notify(message.text, attachments: message.attachments)
    end

    def warning(text, fields: [])
      message = Message.warning(text, fields: fields)
      notify(message.text, attachments: message.attachments)
    end

    def info(text, fields: [])
      message = Message.info(text, fields: fields)
      notify(message.text, attachments: message.attachments)
    end
  end
end
