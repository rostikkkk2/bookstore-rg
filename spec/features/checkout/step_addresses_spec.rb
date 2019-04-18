require 'rails_helper'

describe 'Checkout address step', type: :feature do
  let!(:order) { create(:order, :address_step) }
  let!(:error_empty_message) { "can't be blank" }
  let(:valid_attributes) { attributes_for(:address) }

  before do
    login_as(order.user, scope: :user)
    visit root_path
    click_on(I18n.t('home_page.buy_now'))
    visit carts_path
    click_on(I18n.t('checkout.title'))
  end

  it 'when go to first step checkout' do
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'when click on continue all fields invalid' do
    click_on(I18n.t('checkout.save_and_continue'))
    expect(page).to have_content error_empty_message
  end

  context 'when billing' do
    let(:billing) { create(:address, address_type: 'billing', resource: order.user) }

    it 'billing address exists' do
      billing
      visit checkout_path(step: :address)

      expect(page).to have_field 'billing_form[first_name]', with: billing.first_name
      expect(page).to have_field 'billing_form[last_name]', with: billing.last_name
      expect(page).to have_field 'billing_form[address]', with: billing.address
      expect(page).to have_field 'billing_form[city]', with: billing.city
      expect(page).to have_field 'billing_form[zip]', with: billing.zip
      expect(page).to have_field 'billing_form[country]', with: billing.country
      expect(page).to have_field 'billing_form[phone]', with: billing.phone
    end

    it 'when billing address exists without shipping' do
      billing
      click_on(I18n.t('checkout.save_and_continue'))
      expect(page).to have_content error_empty_message
    end
  end

  context 'when shipping' do
    let(:shipping) { create(:address, address_type: 'shipping', resource: order.user) }

    it 'shipping address exists' do
      shipping
      visit checkout_path(step: :address)

      expect(page).to have_field 'shipping_form[first_name]', with: shipping.first_name
      expect(page).to have_field 'shipping_form[last_name]', with: shipping.last_name
      expect(page).to have_field 'shipping_form[address]', with: shipping.address
      expect(page).to have_field 'shipping_form[city]', with: shipping.city
      expect(page).to have_field 'shipping_form[zip]', with: shipping.zip
      expect(page).to have_field 'shipping_form[country]', with: shipping.country
      expect(page).to have_field 'shipping_form[phone]', with: shipping.phone
    end

    it 'when shipping address exists without billing' do
      shipping
      click_on(I18n.t('checkout.save_and_continue'))
      expect(page).to have_content error_empty_message
    end
  end

  it 'try to go on delivery step' do
    find('a', class: 'step_checkout', text: I18n.t('checkout.delivery_title')).click
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'try to go on payment step' do
    find('a', class: 'step_checkout', text: I18n.t('checkout.payment_title')).click
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'try to go on confirm step' do
    find('a', class: 'step_checkout', text: I18n.t('checkout.confirm_title')).click
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'try to go on complete step' do
    find('a', class: 'step_checkout', text: I18n.t('checkout.complete_title')).click
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'valid inputs' do
    first('#shipping_form_first_name').set valid_attributes[:first_name]
    first('#shipping_form_last_name').set valid_attributes[:last_name]
    first('#shipping_form_address').set valid_attributes[:address]
    first('#shipping_form_city').set valid_attributes[:city]
    fill_in 'shipping_form[zip]', with: valid_attributes[:zip]
    first('#shipping_form_phone').set valid_attributes[:phone]

    first('#billing_form_first_name').set valid_attributes[:first_name]
    first('#billing_form_last_name').set valid_attributes[:last_name]
    first('#billing_form_address').set valid_attributes[:address]
    first('#billing_form_city').set valid_attributes[:city]
    fill_in 'billing_form[zip]', with: valid_attributes[:zip]
    first('#billing_form_phone').set valid_attributes[:phone]

    click_on(I18n.t('checkout.save_and_continue'))
    expect(page).to have_current_path checkout_path(step: :delivery)
  end

  it 'when use one billing with hidden shipping' do
    find('label', class: 'checkbox-label').click

    first('#billing_form_first_name').set valid_attributes[:first_name]
    first('#billing_form_last_name').set valid_attributes[:last_name]
    first('#billing_form_address').set valid_attributes[:address]
    first('#billing_form_city').set valid_attributes[:city]
    fill_in 'billing_form[zip]', with: valid_attributes[:zip]
    first('#billing_form_phone').set valid_attributes[:phone]
    click_on(I18n.t('checkout.save_and_continue'))
    expect(page).to have_current_path checkout_path(step: :delivery)
  end
end
