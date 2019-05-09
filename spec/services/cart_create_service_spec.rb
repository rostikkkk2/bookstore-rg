require 'rails_helper'

RSpec.describe CartCreateService do
  let(:current_user) { create(:user) }
  let(:order) { create(:order) }
  let(:book) { create(:book) }
  let(:params) { { current_book: book.id, count_books: 1 } }

  describe 'item create success' do
    subject(:service) { described_class.new(current_user, params_form, params) }

    let(:params_form) { { current_book: book.id, count_books: 1 } }

    it do
      service.call(order)
      expect(LineItem.second.book).to eq(book)
    end
  end

  describe 'item create failed' do
    subject(:service) { described_class.new(current_user, nil, params) }

    let(:order_items) { 1 }

    it do
      expect(service.call(order)).to eq(nil)
      expect(LineItem.count).to eq(order_items)
    end
  end
end
