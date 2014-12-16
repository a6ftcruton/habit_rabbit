require "codeclimate-test-reporter"
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

ENV['CODECLIMATE_REPO_TOKEN'] = "cb973c5474afd46a077f083f1449bcb7942355fb834ae83600fc0a67493f76be"

CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
