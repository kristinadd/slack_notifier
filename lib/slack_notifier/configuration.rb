# frozen_string_literal: true
module SlackNotifier
  class Configuration
    attr_accessor :webhook_url
    attr_accessor :username
    attr_accessor :channel

    def initialize
      @webhook_url = nil
      @username = "SlackNotifier"
      @channel = nil
    end

    def validate!
      raise StandardError, "webhook_url is required" if webhook_url.nil? || webhook_url.empty?
    end
  end
end
