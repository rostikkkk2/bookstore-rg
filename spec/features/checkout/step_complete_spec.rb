require 'rails_helper'

describe 'Complete page in checkout', type: :feature do
  let!(:delivery_method) { create(:delivery, method: FFaker::Lorem.word) }
  let!(:order) { create(:order, :complete_step, delivery_id: delivery_method.id) }
  let(:add_order_id_to_cookies) { Capybara.current_session.driver.browser.manage.add_cookie(name: :current_order_id, value: "#{order.id}") }


  before do
    visit root_path
    add_order_id_to_cookies
    login_as(order.user, scope: :user)
    visit checkout_path(step: :complete)
  end

  it 'go to step complete' do
    expect(page).to have_current_path checkout_path(step: :complete)
    expect(page).to have_content order.user.email
    expect(page).to have_content order.number
  end

  it 'try to go on address step' do
    find('a', class: 'step_checkout', text: I18n.t('checkout.address_title')).click
    expect(page).to have_content order.user.email
  end

  it 'try to go on delivery step' do
    find('a', class: 'step_checkout', text: I18n.t('checkout.delivery_title')).click
    expect(page).to have_content order.user.email
  end

  it 'try to go on payment step' do
    find('a', class: 'step_checkout', text: I18n.t('checkout.payment_title')).click
    expect(page).to have_content order.user.email
  end

  it 'try to go on confirm step' do
    find('a', class: 'step_checkout', text: I18n.t('checkout.confirm_title')).click
    expect(page).to have_content order.user.email
  end

  it 'back to storage' do
    click_on(I18n.t('checkout.back_to_store'))
    expect(page).to have_current_path root_path
  end
end
