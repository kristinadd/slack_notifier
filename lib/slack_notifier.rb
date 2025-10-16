# frozen_string_literal: true

require_relative "slack_notifier/version"
require_relative "slack_notifier/configuration"
require_relative "slack_notifier/client"
require_relative "slack_notifier/message"

module SlackNotifier
  class Error < StandardError; end

  class << self
    # @return [Configuration] the global configuration object
    attr_writer :configuration

    # Configure the SlackNotifier gem
    #
    # @example
    #   SlackNotifier.configure do |config|
    #     config.webhook_url = "https://hooks.slack.com/services/..."
    #     config.username = "MyBot"
    #   end
    #
    # @yield [Configuration] the configuration object
    def configure
      yield(configuration)
    end

    # @return [Configuration] the current configuration
    def configuration
      @configuration ||= Configuration.new
    end

    # Reset configuration to defaults
    def reset_configuration!
      @configuration = Configuration.new
    end

    # Send a notification to Slack
    #
    # @param text [String] the message text
    # @param options [Hash] additional options
    # @return [Boolean] true if successful
    #
    # @example
    #   SlackNotifier.notify("Hello Slack!")
    def notify(text, options = {})
      client = Client.new
      client.notify(text, options)
    end

    # Send a success notification
    #
    # @param text [String] the message text
    # @param fields [Array<Hash>] optional fields
    # @return [Boolean] true if successful
    #
    # @example
    #   SlackNotifier.success("Deployment completed!")
    def success(text, fields: [])
      message = Message.success(text, fields: fields)
      notify(message.text, attachments: message.attachments)
    end

    # Send an error notification
    #
    # @param text [String] the message text
    # @param fields [Array<Hash>] optional fields
    # @return [Boolean] true if successful
    #
    # @example
    #   SlackNotifier.error("Deployment failed!")
    def error(text, fields: [])
      message = Message.error(text, fields: fields)
      notify(message.text, attachments: message.attachments)
    end

    # Send a warning notification
    #
    # @param text [String] the message text
    # @param fields [Array<Hash>] optional fields
    # @return [Boolean] true if successful
    #
    # @example
    #   SlackNotifier.warning("Disk space low!")
    def warning(text, fields: [])
      message = Message.warning(text, fields: fields)
      notify(message.text, attachments: message.attachments)
    end

    # Send an info notification
    #
    # @param text [String] the message text
    # @param fields [Array<Hash>] optional fields
    # @return [Boolean] true if successful
    #
    # @example
    #   SlackNotifier.info("Server restarted")
    def info(text, fields: [])
      message = Message.info(text, fields: fields)
      notify(message.text, attachments: message.attachments)
    end
  end
end
