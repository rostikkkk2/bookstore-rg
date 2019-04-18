require 'rails_helper'

describe 'Cart page', type: :feature do
  let(:category_mobile) { create(:category, name: 'Mobile') }
  let!(:book) { create(:book, category: category_mobile) }
  let!(:coupon) { create(:coupon) }

  before do
    visit root_path
    click_button('Buy Now')
    visit carts_path
  end

  it 'when add book to cart' do
    expect(page).to have_css '.shop-quantity', text: '1'
    expect(page).to have_content book.name
    expect(page).to have_content book.price
  end

  it 'when delete book form cart' do
    find('button', class: 'general-cart-close', text: '×').click
    expect(page).to have_content 'Your cart is empty'
  end

  context 'when increment and decrement quantity book' do
    let(:quantity_books_after_increment) { '2' }
    let(:quantity_books_after_decrement) { '1' }

    before do
      find('i', class: 'fa-plus').click
    end

    it 'when increment quantity book' do
      expect(page).to have_css '.shop-quantity', text: quantity_books_after_increment
      expect(find('.cart-book-quantity').value).to eq quantity_books_after_increment
    end

    it 'when decrement quantity book' do
      find('i', class: 'fa-minus').click
      expect(page).to have_css '.shop-quantity', text: quantity_books_after_decrement
      expect(find('.cart-book-quantity').value).to eq quantity_books_after_decrement
    end
  end

  it 'when click on apply coupon with empty field' do
    click_button('Apply Coupon')
    expect(page).to have_selector 'div', text: 'wrong coupon'
  end

  it 'when click on cover book' do
    find('img', class: 'general-thumbnail-img').click
    expect(page).to have_current_path book_path(book)
  end

  it 'when not signed in user click on checkout button' do
    find('a', text: 'Checkout').click
    expect(page).to have_current_path checkout_path(step: :quick_registrate)
  end

  it 'when use right coupon' do
    first('#coupon').set coupon.key
    click_button('Apply Coupon')
    expect(page).to have_content 'you used coupon for this order'
  end
end
