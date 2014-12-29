require 'rails_helper'

describe 'visiting dashboard' do
  before do
    @user = User.create(name: "Joe", email_address: "stuff@whatup.com", password: 'password', password_confirmation: 'password')
  end

  it 'from the home page if not logged in' do
    visit dashboard_path
    expect(page).to have_content("Log in with Twitter")
  end

  it 'from the home page if logged in' do
    page.set_rack_session(user_id: @user.id)
    visit dashboard_path
    expect(page).to have_content("Welcome, Joe")
  end
end
