require 'rails_helper'

RSpec.feature 'Home page:' do

  # describe "when welcome" do
  #   # scenario "home page" do
  #   #   expect(page).to have_content I18n.t(:)
  #   # end
  # end
  before do
    visit('/')
  end

  scenario 'located on home page' do
    expect(page).to have_current_path root_path
  end

  scenario "home page" do
     expect(page).to have_content I18n.t('home_page.welcome')
  end



end
