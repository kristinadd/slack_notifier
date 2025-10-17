# frozen_string_literal: true

RSpec.describe SlackNotifier do
  it "has a version number" do
    expect(SlackNotifier::VERSION).not_to be nil
  end
end
