require 'rails_helper'

describe 'Payment card page', type: :feature do
  let(:delivery_method) { create(:delivery, method: FFaker::Lorem.word) }
  let!(:order) { create(:order, :payment_step, delivery_id: delivery_method.id) }
  let(:error_empty_message) { "can't be blank" }
  let(:valid_attributes) { attributes_for(:credit_card) }

  before do
    login_as(order.user, scope: :user)
    visit checkout_path(step: :payment)
  end

  it 'when go to payment step' do
    expect(page).to have_current_path checkout_path(step: :payment)
  end

  it 'when all fields invalid' do
    click_on('Save and Continue')
    expect(page).to have_content error_empty_message
  end

  it 'try to go on delivery step' do
    find('a', class: 'step_checkout', text: 'Address').click
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'try to go on delivery step' do
    find('a', class: 'step_checkout', text: 'Delivery').click
    expect(page).to have_current_path checkout_path(step: :delivery)
  end

  it 'try to go on confirm step' do
    find('a', class: 'step_checkout', text: 'Confirm').click
    expect(page).to have_current_path checkout_path(step: :payment)
  end

  it 'try to go on complete step' do
    find('a', class: 'step_checkout', text: 'Complete').click
    expect(page).to have_current_path checkout_path(step: :payment)
  end

  it 'go to next step with valid fields' do
    fill_in 'credit_card_form[number]', with: valid_attributes[:number]
    fill_in 'credit_card_form[name]', with: valid_attributes[:name]
    fill_in 'credit_card_form[date]', with: valid_attributes[:date]
    fill_in 'credit_card_form[cvv]', with: valid_attributes[:cvv]
    click_on('Save and Continue')
    expect(page).to have_current_path checkout_path(step: :confirm)
  end
end
