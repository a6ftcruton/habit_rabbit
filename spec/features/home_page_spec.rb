require 'rails_helper'

describe "home page" do
  it 'has a button that takes you to the dashboard' do
    sign_in_with_twitter("Yukon Cornelius")
    visit root_path
    click_link_or_button "My Dashboard"
    page.fill_in('phone', with: '5014993998')
    click_link_or_button 'Create'
    expect(page).to have_content("Settings")
  end

  it 'does not have the button if not logged in' do
    visit root_path
    expect(page).to_not have_content("My Dashboard")
  end
end
