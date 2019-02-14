require 'rails_helper'

RSpec.feature 'Home page:' do
  let!(:category) { create(:category, name: 'Mobile') }
  let!(:book) { create(:book, name: 'A', category: category, price: 10) }

  before do
    visit('/')
  end

  scenario 'located on home page' do
    expect(page).to have_current_path root_path
  end

  scenario "home page" do
     expect(page).to have_content I18n.t('home_page.welcome')
  end

  scenario "go to category page" do
    click_link('Shop')
    # click_button('Shop')
     # expect(page).to have_content ('Mobile')
  end
end
