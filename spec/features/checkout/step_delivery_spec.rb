require 'rails_helper'

describe 'Checkout address step', type: :feature do
  let!(:delivery_method) { create(:delivery, method: FFaker::Lorem.word) }
  let!(:order) { create(:order, :delivery_step, delivery_id: delivery_method.id) }

  before do
    login_as(order.user, scope: :user)
    visit checkout_path(step: :delivery)
  end

  it 'go to step delivery' do
    expect(page).to have_current_path checkout_path(step: :delivery)
  end

  it 'try to go on address step' do
    find('a', class: 'step_checkout', text: 'Address').click
    expect(page).to have_current_path checkout_path(step: :address)
  end

  it 'try to go on payment step' do
    find('a', class: 'step_checkout', text: 'Payment').click
    expect(page).to have_current_path checkout_path(step: :delivery)
  end

  it 'try to go on confirm step' do
    find('a', class: 'step_checkout', text: 'Confirm').click
    expect(page).to have_current_path checkout_path(step: :delivery)
  end

  it 'try to go on complete step' do
    find('a', class: 'step_checkout', text: 'Complete').click
    expect(page).to have_current_path checkout_path(step: :delivery)
  end

  it 'click submit with checked delivery method' do
    click_on('Save and Continue')
    expect(page).to have_current_path checkout_path(step: :payment)
  end
end
