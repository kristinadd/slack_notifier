# frozen_string_literal: true

module SlackNotifier
  # Message class for creating formatted Slack messages
  #
  # @example
  #   message = SlackNotifier::Message.success("Deployment completed!")
  #   client.notify(message.text, attachments: message.attachments)
  class Message
    # Slack color codes for different message types
    COLORS = {
      success: "good",      # Green
      error: "danger",      # Red
      warning: "warning",   # Yellow
      info: "#439FE0"       # Blue
    }.freeze

    # Emoji icons for different message types
    ICONS = {
      success: ":white_check_mark:",
      error: ":x:",
      warning: ":warning:",
      info: ":information_source:"
    }.freeze

    # @return [String] the message text
    attr_reader :text

    # @return [Array<Hash>] the Slack attachments
    attr_reader :attachments

    # @return [Symbol] the message type
    attr_reader :type

    # Initialize a new Message
    #
    # @param text [String] the message text
    # @param type [Symbol] the message type (:success, :error, :warning, :info)
    # @param fields [Array<Hash>] optional fields to display
    def initialize(text, type: :info, fields: [])
      @text = text
      @type = type
      @attachments = build_attachments(text, type, fields)
    end

    # Create a success message
    #
    # @param text [String] the message text
    # @param fields [Array<Hash>] optional fields
    # @return [Message] the formatted message
    def self.success(text, fields: [])
      new(text, type: :success, fields: fields)
    end

    # Create an error message
    #
    # @param text [String] the message text
    # @param fields [Array<Hash>] optional fields
    # @return [Message] the formatted message
    def self.error(text, fields: [])
      new(text, type: :error, fields: fields)
    end

    # Create a warning message
    #
    # @param text [String] the message text
    # @param fields [Array<Hash>] optional fields
    # @return [Message] the formatted message
    def self.warning(text, fields: [])
      new(text, type: :warning, fields: fields)
    end

    # Create an info message
    #
    # @param text [String] the message text
    # @param fields [Array<Hash>] optional fields
    # @return [Message] the formatted message
    def self.info(text, fields: [])
      new(text, type: :info, fields: fields)
    end

    private

    # Build Slack attachments with color and formatting
    #
    # @param text [String] the message text
    # @param type [Symbol] the message type
    # @param fields [Array<Hash>] optional fields
    # @return [Array<Hash>] the formatted attachments
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

