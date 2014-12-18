require 'rails_helper'

describe 'notifications', type: :feature do
  include Capybara::DSL

  it 'visits dashboard' do
    visit '/dashboard'
    expect(page).to have_content "Welcome"
  end

end
