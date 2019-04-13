require 'rails_helper'

describe 'Home page', type: :feature do
  let(:category_all_books) { create(:category, name: 'All books') }
  let(:category_mobile) { create(:category, name: 'Mobile') }
  let!(:book) { create(:book, category: category_mobile) }

  before do
    visit(root_path)
  end

  it 'located on home page' do
    expect(page).to have_current_path root_path
  end

  it 'home page' do
    expect(page).to have_content I18n.t('home_page.welcome')
  end

  it 'go to category all by button Get started' do
    click_link('Get Started')
    expect(page).to have_current_path books_path
  end

  it 'redirect to catalog page' do
    category_mobile
    find('a', class: 'dropdown-toggle', text: 'Shop').click
    click_link(category_mobile.name)
    expect(page).to have_current_path category_books_path(category_mobile.id)
  end

  it "redirect to current book page after click name book in slider" do
    click_link(book.name)
    expect(page).to have_current_path book_path(book.id)
  end

  it 'go to clear cart' do
    find('span', class: 'shop-icon').click
    expect(page).to have_content 'Your cart is empty'
    expect(page).to have_current_path carts_path
  end

  it 'go to sign in page' do
    click_link('Log in')
    expect(page).to have_current_path new_user_session_path
  end

  it 'go to sign up page' do
    click_link('Sign up')
    expect(page).to have_current_path new_user_registration_path
  end

  it 'add book to cart form slider' do
    click_button('Buy Now')
    expect(page).to have_css '.shop-quantity', text: '1'
    expect(LineItem.count).to eq(1)
  end

  it 'go to catalog from footer link' do
    category_all_books
    find('a', class: 'link-footer', text: 'Shop').click
    expect(page).to have_current_path books_path
  end

  it 'go to setting from footer with not signed in user' do
    find('a', class: 'link-footer', text: 'Settings').click
    page.evaluate_script 'window.location.reload()'
    expect(page).to have_current_path new_user_session_path
  end

  it 'go to orders from footer link with not signed in user' do
    find('a', class: 'link-footer', text: 'Orders').click
    expect(page).to have_content 'You are not authorized to access this page.'
    expect(page).to have_current_path root_path
  end
end
