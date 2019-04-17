require 'rails_helper'

describe 'Quick registrate', type: :feature do
  let!(:order) { create(:order, user_id: nil) }
  let(:user) { create(:user) }
  let(:error_massage) { 'Invalid Email or password' }
  let(:valid_attributes) { attributes_for(:user) }

  before do
    visit root_path
    click_button('Buy Now')
    visit carts_path
    click_on('Checkout')
  end

  it 'show quick registration page' do
    expect(page).to have_current_path checkout_path(step: :quick_registrate)
  end

  it 'when click log in with empty fields' do
    click_button('Log In with Password')
    expect(page).to have_content error_massage
  end

  it 'when click log in with empty password' do
    first('#email').set user.email
    first('#password').set ''
    click_button('Log In with Password')
    expect(page).to have_current_path new_user_session_path
  end

  it 'when click log in with empty email' do
    first('#email').set ''
    first('#password').set user.password
    click_button('Log In with Password')
    expect(page).to have_current_path new_user_session_path
  end

  it 'when click log in with right password and email' do
    first('#email').set user.email
    first('#password').set user.password
    click_button('Log In with Password')
    expect(page).to have_selector 'a', text: 'My account'
    expect(page).to have_current_path root_path
  end

  it 'when click to forgot email' do
    find('a', text: 'Forgot your password?').click
    expect(page).to have_content 'Forgot your password?'
  end

  it 'when click to sign up with empty email' do
    click_on('Sign up')
    expect(page).to have_current_path new_user_registration_path
  end

  it 'when click on sign up with exists email' do
    all('#email').last.set user.email
    click_on('Sing Up')
    expect(page).to have_content 'email exists'
  end

  it 'when click on sign up with right email' do
    all('#email').last.set valid_attributes[:email]
    click_on('Sing Up')
    expect(page).to have_selector 'a', text: 'My account'
  end
end
