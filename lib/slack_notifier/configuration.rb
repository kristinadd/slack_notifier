# frozen_string_literal: true

module SlackNotifier
  # Configuration class for storing Slack webhook settings
  #
  # @example
  #   SlackNotifier.configure do |config|
  #     config.webhook_url = "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
  #   end
  class Configuration
    # @return [String] the Slack webhook URL
    attr_accessor :webhook_url

    # @return [String] default username for messages
    attr_accessor :username

    # @return [String] default channel to post messages to
    attr_accessor :channel

    def initialize
      @webhook_url = nil
      @username = "SlackNotifier"
      @channel = nil
    end

    # Validates that required configuration is present
    #
    # @raise [ConfigurationError] if webhook_url is not set
    def validate!
      raise ConfigurationError, "webhook_url is required" if webhook_url.nil? || webhook_url.empty?
    end
  end

  # Custom error class for configuration issues
  class ConfigurationError < Error; end
end

