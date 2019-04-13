require 'rails_helper'

describe 'Sign up page', type: :feature do
  let(:empty_field) { "can't be blank" }
  let(:test_password) { '123456' }
  let(:test_email) { 'test@example.com' }
  let(:error_wrong_confirm_password) { "doesn't match Password" }

  before do
    visit new_user_registration_path
  end

  it 'click to sign up with clear fields' do
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_on('Sign Up')
    expect(page).to have_content empty_field
  end

  it 'click to sign up with wrong email' do
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: test_password
    fill_in 'user[password_confirmation]', with: test_password
    click_on('Sign Up')
    expect(page).to have_content empty_field
  end

  it 'click to sign up with wrong password' do
    fill_in 'user[email]', with: test_email
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_on('Sign Up')
    expect(page).to have_content empty_field
  end

  it 'click to sign up with wrong confirm password' do
    fill_in 'user[email]', with: test_email
    fill_in 'user[password]', with: test_password
    fill_in 'user[password_confirmation]', with: ''
    click_on('Sign Up')
    expect(page).to have_content error_wrong_confirm_password
  end

  it 'when all fields right' do
    fill_in 'user[email]', with: test_email
    fill_in 'user[password]', with: test_password
    fill_in 'user[password_confirmation]', with: test_password
    click_on('Sign Up')
    expect(page).to have_selector 'a', text: 'My account'
    expect(page).to have_current_path root_path
  end

  it 'when click to log in' do
    find('a', class: 'default-orange', text: 'Log In').click
    expect(page).to have_current_path new_user_session_path
  end
end
