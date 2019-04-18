require 'rails_helper'

describe 'Current book page', type: :feature do
  let!(:book) { create(:book) }

  before do
    visit book_path(book)
  end

  context 'when increment count book and add to cart' do
    let(:count_books_after_increment) { '2' }

    before do
      find('i', class: 'fa-plus').click
    end

    it 'increment count book before add to cart' do
      expect(find_field('count_books').value).to eq count_books_after_increment
    end

    it 'add book to cart' do
      click_button('Add to Cart')
      expect(page).to have_css '.shop-quantity', text: count_books_after_increment
    end
  end

  it 'when click on read more' do
    find('a', id: 'btn_read_more', text: 'Read More').click
    expect(page).to have_selector 'a', text: I18n.t('book_page.hide_read_more')
  end

  it 'when click to button back and show category page' do
    visit books_path
    visit book_path(book)
    find('a', class: 'general-back-link', text: I18n.t('book_page.back')).click
    expect(page).to have_current_path books_path
  end
end
