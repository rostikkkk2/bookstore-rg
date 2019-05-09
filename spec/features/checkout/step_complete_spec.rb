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

  it 'back to storage' do
    click_on(I18n.t('checkout.back_to_store'))
    expect(page).to have_current_path root_path
  end
end
