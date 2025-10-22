# frozen_string_literal: true

require "httparty"
require "json"
module SlackNotifier
  class Client
    include HTTParty

    attr_reader :config

    def initialize(config = nil)
      @config = config || SlackNotifier.configuration
      @config.validate!
    end

    def notify(text, options = {})
      payload = build_payload(text, options)
      
      response = self.class.post(
        config.webhook_url,
        body: payload.to_json,
        headers: { "Content-Type" => "application/json" }
      )

      response.success?
    end

    private

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

  end
end
