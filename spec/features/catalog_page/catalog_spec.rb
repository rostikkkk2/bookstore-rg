require 'rails_helper'

describe 'Catalog page', type: :feature do
  let(:category_mobile) { create(:category, name: 'Mobile') }
  let!(:book) { create(:book, category: category_mobile) }

  before do
    visit(books_path)
  end

  it 'add book to cart' do
    first('.thumbnail').hover
    find('button', class: 'button-add-to-cart-from-category').click
    expect(page).to have_css '.shop-quantity', text: '1'
  end

  it 'go to current book page' do
    first('.thumbnail').hover
    find('a', class: 'thumb-hover-link').click
    expect(page).to have_current_path book_path(book.id)
  end

  it 'go to mobile category' do
    find('a', class: 'filter-link', text: category_mobile.name).click
    expect(page).to have_current_path category_books_path(category_mobile.id)
  end
end
