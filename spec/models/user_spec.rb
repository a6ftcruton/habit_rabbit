require 'rails_helper'
describe "user" do

  it 'can create a user with a name and email' do
    user = User.new(name: 'joe', email_address: 'stuff@yomama.com')
    expect(user).to be_valid
  end

  it 'cannot create a user without a name or email' do
    user = User.new(name: 'joe')
    expect(user).to_not be_valid
    user2 = User.new(email_address: 'stuff@yomama.com')
    expect(user2).to_not be_valid
  end

  it 'can have a phone number' do
    user = User.new(name: 'joe')
    expect
  end
end
