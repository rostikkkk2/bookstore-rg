require 'rails_helper'

describe 'Settings page', type: :feature do
  let!(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:address) }

  before do
    login_as(user, scope: :user)
    visit new_setting_path
  end

  it 'when go to settings page' do
    expect(page).to have_current_path new_setting_path
    expect(page).to have_selector 'h1', text: I18n.t('settings.title')
  end

  context 'when billing' do
    let(:billing) { create(:address, address_type: 'billing', resource: user) }

    it 'when save billing address with empty fields' do
      first('input[type=submit]').click
      expect(page).to have_content "can't be blank, must write with big letter"
    end

    it 'billing address exists' do
      billing
      visit new_setting_path

      expect(page).to have_field 'billing_form[first_name]', with: billing.first_name
      expect(page).to have_field 'billing_form[last_name]', with: billing.last_name
      expect(page).to have_field 'billing_form[address]', with: billing.address
      expect(page).to have_field 'billing_form[city]', with: billing.city
      expect(page).to have_field 'billing_form[zip]', with: billing.zip
      expect(page).to have_field 'billing_form[country]', with: billing.country
      expect(page).to have_field 'billing_form[phone]', with: billing.phone
    end

    it 'valid input' do
      first('#billing_form_first_name').set valid_attributes[:first_name]
      first('#billing_form_last_name').set valid_attributes[:last_name]
      first('#billing_form_address').set valid_attributes[:address]
      first('#billing_form_city').set valid_attributes[:city]
      fill_in 'billing_form[zip]', with: valid_attributes[:zip]
      first('#billing_form_phone').set valid_attributes[:phone]
      first('input[type=submit]').click
      expect(Address.count).to eq(1)
    end
  end

  context 'when shipping' do
    let(:shipping) { create(:address, address_type: 'shipping', resource: user) }

    it 'when save billing address with empty fields' do
      all('input[type=submit]').last.click
      expect(page).to have_content "can't be blank, must write with big letter"
    end

    it 'shipping address exists' do
      shipping
      visit new_setting_path

      expect(page).to have_field 'shipping_form[first_name]', with: shipping.first_name
      expect(page).to have_field 'shipping_form[last_name]', with: shipping.last_name
      expect(page).to have_field 'shipping_form[address]', with: shipping.address
      expect(page).to have_field 'shipping_form[city]', with: shipping.city
      expect(page).to have_field 'shipping_form[zip]', with: shipping.zip
      expect(page).to have_field 'shipping_form[country]', with: shipping.country
      expect(page).to have_field 'shipping_form[phone]', with: shipping.phone
    end

    it 'valid input' do
      first('#shipping_form_first_name').set valid_attributes[:first_name]
      first('#shipping_form_last_name').set valid_attributes[:last_name]
      first('#shipping_form_address').set valid_attributes[:address]
      first('#shipping_form_city').set valid_attributes[:city]
      fill_in 'shipping_form[zip]', with: valid_attributes[:zip]
      first('#shipping_form_phone').set valid_attributes[:phone]
      all('input[type=submit]').last.click
      expect(Address.count).to eq(1)
    end
  end
end
