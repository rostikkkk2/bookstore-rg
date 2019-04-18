require 'rails_helper'

describe 'Orders page', type: :feature do
  let!(:delivery_method) { create(:delivery, method: FFaker::Lorem.word) }
  let!(:order) { create(:order, :complete_step, delivery_id: delivery_method.id) }

  before do
    login_as(order.user, scope: :user)
    visit orders_path
  end

  it 'show orders page' do
    expect(page).to have_content 'My Orders'
    expect(page).to have_content order.number
  end

  it 'when click to current order number' do
    click_on(order.number)
    expect(page).to have_current_path order_path(order)
  end

  context 'when see current order data' do
    let(:billing_object) { order.addresses.billing.first }
    let(:shipping_object) { order.addresses.shipping.first }

    before do
      click_on(order.number)
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
  end
end
