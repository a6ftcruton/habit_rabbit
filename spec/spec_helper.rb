require "codeclimate-test-reporter"

ENV['CODECLIMATE_REPO_TOKEN'] = "cb973c5474afd46a077f083f1449bcb7942355fb834ae83600fc0a67493f76be"

CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # SmsSpec.driver = :"twilio-ruby"

  def sign_in_with_twitter
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      'provider' => 'twitter',
      'uid' => "1580517942",
      'info' => { "name" => "Yukon Cornelius",
                  "image" => 'http://pbs.twimg.com/profile_images/37880000010996' },
      'credentials' => {
                  "token" => '1580517942-CyrOIdoU2cTwu4fQvclmRkM95OQUbCKbPnwUdLr',
                  "secret" => '3BHUkZsVUZYn0c0J19mv0iuDghiCK55ZUGkDZTCpjPn9d' }
    })
    visit "/auth/twitter/callback"
  end
end
