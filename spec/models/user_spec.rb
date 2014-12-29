require 'rails_helper'

describe "user" do

  describe "non-twitter user creation" do
    it 'can create a user with a name and email and password and confirmation' do
      user = User.new(name: 'joe',
                      email_address: 'stuff@yomama.com',
                      password: "password",
                      password_confirmation: "password")
      expect(user).to be_valid
    end

    it 'cannot create a user without a name or email' do
      user = User.new(name: 'joe')
      expect(user).to_not be_valid
      user2 = User.new(email_address: 'stuff@yomama.com')
      expect(user2).to_not be_valid
    end

    it "requires password and matching confirmation" do
      expect(User.new(:name => "hi", :email_address => "hi")).to_not be_valid
      expect(User.new(:name => "hi", :email_address => "hi", :password => "wat", :password_confirmation => "sdfasfsadf")).to_not be_valid
    end
  end


  describe ".from_omniauth" do
    it "creates a user from an omniauth auth hash" do
      auth = OmniAuth::AuthHash.new(
        {:provider => "twitter",
         :uid => "1234",
         :info => {:name => "pizza man", :image => "za.jpg"},
         :credentials => {:token => "mytoken", :secret => "mysecret"}
         }
      )
      user = User.from_omniauth(auth)
      expect(user).to be_valid
    end
  end

  describe "#is_twitter?" do
    it "is true if the user has all the required twitter pieces" do
      u = User.new(:uid => "1234", :provider => "twitter", :oauth_token => "token", :oauth_secret => "secret")
      expect(u.is_twitter?).to eq(true)
      u.uid = nil
      expect(u.is_twitter?).to eq(false)
    end
  end

  it 'can have a phone number' do
    user = User.new(name: 'joe')
    # expect
  end
end
