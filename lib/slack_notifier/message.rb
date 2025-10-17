# frozen_string_literal: true

module SlackNotifier
  # Message class for creating formatted Slack messages
  #
  # @example
  #   message = SlackNotifier::Message.success("Deployment completed!")
  #   client.notify(message.text, attachments: message.attachments)
  class Message
    COLORS = {
      success: "good",      # Green
      error: "danger",      # Red
      warning: "warning",   # Yellow
      info: "#439FE0"       # Blue
    }.freeze

    ICONS = {
      success: ":white_check_mark:",
      error: ":x:",
      warning: ":warning:",
      info: ":information_source:"
    }.freeze

    attr_reader :text

    attr_reader :attachments

    attr_reader :type

    def initialize(text, type: :info, fields: [])
      @text = text
      @type = type
      @attachments = build_attachments(text, type, fields)
    end

    def self.success(text, fields: [])
      new(text, type: :success, fields: fields)
    end

    def self.error(text, fields: [])
      new(text, type: :error, fields: fields)
    end

    def self.warning(text, fields: [])
      new(text, type: :warning, fields: fields)
    end

    def self.info(text, fields: [])
      new(text, type: :info, fields: fields)
    end

    private

    def build_attachments(text, type, fields)
      [
        {
          color: COLORS[type],
          text: "#{ICONS[type]} #{text}",
          fields: fields,
          footer: "SlackNotifier",
          ts: Time.now.to_i
        }
      ]
    end
  end
end

