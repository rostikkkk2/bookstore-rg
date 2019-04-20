require 'rails_helper'

describe 'Catalog page', type: :feature do
  let!(:book) { create(:book) }

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
    find('a', class: 'filter-link', text: book.category.name).click
    expect(page).to have_current_path category_books_path(book.category.id)
  end
end
