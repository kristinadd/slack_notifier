# frozen_string_literal: true

require_relative "lib/slack_notifier/version"

Gem::Specification.new do |spec|
  spec.name = "slack_notifier"
  spec.version = SlackNotifier::VERSION
  spec.authors = ["kristinadd"]
  spec.email = ["christina.d.docheva@gmail.com"]

  spec.summary = "A simple Slack notification gem for Rails applications"
  spec.description = "Send formatted notifications to Slack channels via webhooks. Supports success, error, and info message types."
  spec.homepage = "https://github.com/kristinadd/slack_notifier"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kristinadd/slack_notifier"
  spec.metadata["changelog_uri"] = "https://github.com/kristinadd/slack_notifier/blob/main/CHANGELOG.md"
  
  # By not setting allowed_push_host, we allow publishing to rubygems.org

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
