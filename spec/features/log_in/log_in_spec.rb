require 'rails_helper'

describe 'Log in', type: :feature do
  let(:user) { create(:user) }
  let(:error_massage) { 'Invalid Email or password' }

  before do
    visit new_user_session_path
  end

  it 'when click log in with empty fields' do
    click_button('Log in')
    expect(page).to have_content error_massage
  end

  it 'when click log in with empty password' do
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: ''
    click_button('Log in')
    expect(page).to have_content error_massage
  end

  it 'when click log in with empty email' do
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: user.password
    click_button('Log in')
    expect(page).to have_content error_massage
  end

  it 'when click log in with right password and email' do
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button('Log in')
    expect(page).to have_selector 'a', text: 'My account'
    expect(page).to have_current_path root_path
  end

  it 'when click to forgot email' do
    find('a', text: 'Forgot your password?').click
    expect(page).to have_content 'Forgot your password?'
  end

  it 'when click to sign up' do
    find('a', class: 'default-orange', text: 'Sign up').click
    expect(page).to have_current_path new_user_registration_path
  end
end
