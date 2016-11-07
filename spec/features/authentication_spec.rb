require 'rails_helper'
require 'features/support/env'

feature 'Authentication' do
  scenario 'user can log in by email and password', js: true do
    @user = FactoryGirl.create(:user)
    visit '/'
    click_link('Log In')
    expect(page).to have_selector("input[id='email']")
    expect(page).to have_selector("input[id='password']")
    log_in_valid_params
    expect(page).to have_content('Log Out')
  end

  scenario 'user cannot log in if invalid email or password', js: true do
    @user = FactoryGirl.create(:user)
    visit '/'
    log_in_invalid_params
  end

  scenario 'user can register', js: true do
    visit '/'
    click_link('Register')
    expect(page).to have_selector("input[id='email']")
    expect(page).to have_selector("input[id='password']")
    register
    expect(page).to have_content('Log Out')
  end

  scenario 'user cannot register if email is registered', js: true do
    FactoryGirl.create(:user, email: 'test@test.test')
    visit '/'
    click_link('Register')
    expect(page).to have_selector("input[id='email']")
    expect(page).to have_selector("input[id='password']")
    register
    expect(page).to have_content('Email is registered')
  end

  private
    def register
      fill_in 'email', with: 'test@test.test'
      fill_in 'password', with: '123456'
      expect(find("input[id='email']").value).to eq('test@test.test')
      click_button('Register')
    end

    def log_in_valid_params
      fill_in 'email', with: @user.email
      fill_in 'password', with: '123456'
      expect(find("input[id='email']").value).to eq(@user.email)
      click_button('Log In')
    end

    def log_in_invalid_params
      fill_in 'email', with: @user.email
      fill_in 'password', with: 'wrong password'
      expect(find("input[id='email']").value).to eq(@user.email)
      click_button('Log In')
      expect(page).to have_content('Invalid email or password')
    end
end