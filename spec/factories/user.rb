FactoryGirl.define do
  factory :user do
    name "Joe"
    uid "12345"
    provider "twitter"
    image 'http://example.com/image/12342345'
    oauth_token "fjdkslfaPOI"
    oauth_secret "abc123"
  end
end
