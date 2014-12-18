require "codeclimate-test-reporter"

ENV['CODECLIMATE_REPO_TOKEN'] = "cb973c5474afd46a077f083f1449bcb7942355fb834ae83600fc0a67493f76be"
CodeClimate::TestReporter.start

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.infer_spec_type_from_file_location!

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
