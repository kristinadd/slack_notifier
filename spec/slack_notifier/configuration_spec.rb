# frozen_string_literal: true

RSpec.describe SlackNotifier::Configuration do
  describe "#initialize" do
    it "sets default values" do
      config = SlackNotifier::Configuration.new
      
      expect(config.webhook_url).to be_nil
      expect(config.username).to eq("SlackNotifier")
      expect(config.channel).to be_nil
    end
  end

  describe "#validate!" do
    context "when webhook_url is set" do
      it "does not raise an error" do
        config = SlackNotifier::Configuration.new
        config.webhook_url = "https://hooks.slack.com/services/TEST"
        
        expect { config.validate! }.not_to raise_error
      end
    end

    context "when webhook_url is not set" do
      it "raises a ConfigurationError" do
        config = SlackNotifier::Configuration.new
        
        expect { config.validate! }.to raise_error(SlackNotifier::ConfigurationError, "webhook_url is required")
      end
    end

    context "when webhook_url is empty string" do
      it "raises a ConfigurationError" do
        config = SlackNotifier::Configuration.new
        config.webhook_url = ""
        
        expect { config.validate! }.to raise_error(SlackNotifier::ConfigurationError, "webhook_url is required")
      end
    end
  end
end

