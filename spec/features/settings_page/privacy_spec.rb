require 'rails_helper'

describe 'Settings privacy page', type: :feature do
  let!(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
    visit new_setting_path
    find('a', text: 'Privacy').click
  end

  context 'when change email' do
    let(:new_test_email) { 'new_test@example.com' }
    let(:error_message_email) { "Email can't be blank and Email is invalid" }
    let(:success_message_email) { 'Your email successfuly update' }

    it 'when click on submit with empty field' do
      fill_in 'email', with: ''
      first('input[type=submit]').click
      expect(page).to have_content error_message_email
    end

    it 'when successfuly change email' do
      fill_in 'email', with: new_test_email
      first('input[type=submit]').click
      expect(page).to have_content success_message_email
    end
  end

  context 'when change password' do
    let(:new_password) { '654321' }
    let(:error_message_password) { 'Wrong password' }
    let(:successfuly_update_password_messave) { 'Successfuly changed password' }

    it 'click on submit with empty field' do
      click_on('Update')
      expect(page).to have_content error_message_password
    end

    it 'click on submit with wrong current password' do
      fill_in 'old_password', with: new_password
      fill_in 'new_password', with: new_password
      fill_in 'confirm_password', with: new_password
      click_on('Update')
      expect(page).to have_content error_message_password
    end

    it 'click on submit with all valid fields' do
      fill_in 'old_password', with: user.password
      fill_in 'new_password', with: new_password
      fill_in 'confirm_password', with: new_password
      click_on('Update')
      expect(page).to have_content successfuly_update_password_messave
    end
  end

  context 'delete account' do
    let(:successfuly_deleted_account_message) { 'Your account successfuly deleted' }

    it 'when submit and delete account' do
      find('span', class: 'checkbox-icon').click
      click_on('Please Remove My Account')
      expect(page).to have_content successfuly_deleted_account_message
    end
  end
end
