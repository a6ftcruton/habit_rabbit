describe 'unauthenticated user', type: :feature do
  include Capybara::DSL

  describe 'logging in' do
    it 'can log in using email from home page' do
      user = User.create(name: 'Aaron',
                         email_address: 'stuff@yomama.com',
                         password: 'password',
                         password_confirmation: 'password'
                         )
      visit root_path
      click_link 'Log in with Email'
      fill_in 'user_email_address', with: 'stuff@yomama.com'
      fill_in 'user_password', with: 'password'
      click_link_or_button 'Login'
      expect(page).to have_content("Welcome, Aaron")
    end
  end

  describe 'creating an account with email' do
    it 'can create an account using email from home page' do
      visit root_path
      click_link "Create Account with Email"
      fill_in 'user_name', with: 'Aaron'
      fill_in 'user_email_address', with: 'jokes@laugh.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_link_or_button 'Create My Account'
      expect(page).to have_content("Welcome, Aaron")
    end
  end
end
