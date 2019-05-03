require 'rails_helper'

describe 'Confirm checkout step', type: :feature do
  let(:delivery_method) { create(:delivery, method: FFaker::Lorem.word) }
  let!(:order) { create(:order, :confirm_step, delivery_id: delivery_method.id) }
  let(:add_order_id_to_cookies) { Capybara.current_session.driver.browser.manage.add_cookie(name: :current_order_id, value: "#{order.id}") }
  let(:billing_object) { order.addresses.billing.first }
  let(:shipping_object) { order.addresses.shipping.first }

  before do
    visit root_path
    add_order_id_to_cookies
    login_as(order.user, scope: :user)
    visit checkout_path(step: :confirm)
  end

  it 'when go to confirm step' do
    expect(page).to have_current_path checkout_path(step: :confirm)
  end

  it 'show billing address data created before' do
    expect(page).to have_content billing_object.first_name
    expect(page).to have_content billing_object.address
    expect(page).to have_content billing_object.city
    expect(page).to have_content billing_object.country
    expect(page).to have_content billing_object.phone
  end

  it 'show shipping address data created before' do
    expect(page).to have_content shipping_object.first_name
    expect(page).to have_content shipping_object.address
    expect(page).to have_content shipping_object.city
    expect(page).to have_content shipping_object.country
    expect(page).to have_content shipping_object.phone
  end

  it 'show delivery method created before' do
    expect(page).to have_content delivery_method.method
  end

  it 'show card number last 4 nums created before' do
    expect(page).to have_content order.credit_card.number.chars.last(ConfirmPresenter::COUNT_NUMS_CARD_SHOW).join
  end

  it 'when click on edit billing' do
    first('a', class: 'step-address', text: I18n.t('checkout.edit')).click
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'when click on edit shipping' do
    all('a', class: 'step-address', text: I18n.t('checkout.edit')).last.click
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'when click on edit delivery' do
    find('a', class: 'step-delivery', text: I18n.t('checkout.edit')).click
    expect(page).to have_current_path checkout_path(step: :fill_delivery)
  end

  it 'when click on edit payment' do
    find('a', class: 'step-payment', text: I18n.t('checkout.edit')).click
    expect(page).to have_current_path checkout_path(step: :payment)
  end

  it 'go to complete step' do
    click_on(I18n.t('checkout.place_order'))
    expect(page).to have_current_path checkout_path(step: :complete)
  end
end
