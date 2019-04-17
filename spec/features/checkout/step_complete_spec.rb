require 'rails_helper'

describe 'Complete page in checkout', type: :feature do
  let!(:delivery_method) { create(:delivery, method: FFaker::Lorem.word) }
  let!(:order) { create(:order, :complete_step, delivery_id: delivery_method.id) }

  before do
    login_as(order.user, scope: :user)
    visit checkout_path(step: :complete)
  end

  it 'go to step complete' do
    expect(page).to have_current_path checkout_path(step: :complete)
    expect(page).to have_content order.user.email
    expect(page).to have_content order.number
  end

  it 'try to go on address step' do
    find('a', class: 'step_checkout', text: 'Address').click
    expect(page).to have_content order.user.email
  end

  it 'try to go on delivery step' do
    find('a', class: 'step_checkout', text: 'Delivery').click
    expect(page).to have_content order.user.email
  end

  it 'try to go on payment step' do
    find('a', class: 'step_checkout', text: 'Payment').click
    expect(page).to have_content order.user.email
  end

  it 'try to go on confirm step' do
    find('a', class: 'step_checkout', text: 'Confirm').click
    expect(page).to have_content order.user.email
  end

  it 'back to storage' do
    click_on('Back to Store')
    expect(page).to have_current_path root_path
  end
end
