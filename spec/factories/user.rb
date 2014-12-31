FactoryGirl.define do
  factory :user do
    name "Yukon Cornelius"
    email_address "joe@example.com"
    uid "12345"
    provider "twitter"
    image 'http://example.com/image/12342345'
    oauth_token "fjdkslfaPOI"
    oauth_secret "abc123"
  end
end
