# frozen_string_literal: true

require "httparty"
require "json"

module SlackNotifier
  # Client class responsible for sending messages to Slack
  #
  # @example
  #   client = SlackNotifier::Client.new
  #   client.notify("Hello from SlackNotifier!")
  class Client
    include HTTParty

    # @return [Configuration] the configuration object
    attr_reader :config

    # Initialize a new Client
    #
    # @param config [Configuration] optional configuration object
    def initialize(config = nil)
      @config = config || SlackNotifier.configuration
      @config.validate!
    end

    # Send a notification to Slack
    #
    # @param text [String] the message text
    # @param options [Hash] additional options
    # @option options [String] :username override the default username
    # @option options [String] :channel override the default channel
    # @option options [String] :icon_emoji emoji to use as icon (e.g., ":robot_face:")
    # @option options [Array<Hash>] :attachments Slack message attachments
    #
    # @return [Boolean] true if successful, false otherwise
    #
    # @example
    #   client.notify("Deployment completed!", username: "DeployBot")
    def notify(text, options = {})
      payload = build_payload(text, options)
      
      response = self.class.post(
        config.webhook_url,
        body: payload.to_json,
        headers: { "Content-Type" => "application/json" }
      )

      response.success?
    rescue StandardError => e
      handle_error(e)
      false
    end

    private

    # Build the Slack message payload
    #
    # @param text [String] the message text
    # @param options [Hash] additional options
    # @return [Hash] the formatted payload
    def build_payload(text, options)
      payload = {
        text: text,
        username: options[:username] || config.username
      }

      payload[:channel] = options[:channel] || config.channel if config.channel
      payload[:icon_emoji] = options[:icon_emoji] if options[:icon_emoji]
      payload[:attachments] = options[:attachments] if options[:attachments]

      payload
    end

    # Handle errors during notification
    #
    # @param error [StandardError] the error that occurred
    def handle_error(error)
      warn "SlackNotifier Error: #{error.class} - #{error.message}"
    end
  end
end

