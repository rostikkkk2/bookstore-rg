require 'rails_helper'

RSpec.describe MergeItemsCartService do
  let(:current_user) { create(:user) }
  let(:session_order) { create(:order, user_id: nil) }

  describe 'set session order user id' do
    subject(:service) { described_class.new(session_order, current_user) }

    it do
      expect(service.call).to eq(true)
      expect(session_order.user_id).to eq(current_user.id)
    end
  end

  describe 'set line_items user order id' do
    let!(:current_order_user) { create(:order, user_id: current_user.id) }
    subject(:service) { described_class.new(session_order, current_user) }

    it do
      service.call
      expect(current_user.orders.first.line_items.count).to eq(2)
    end
  end

  describe 'add quantity to user order line item' do
    let!(:current_order_user) { create(:order, user_id: current_user.id) }
    let(:book) { create(:book) }
    let!(:item) { create(:line_item, quantity: 1, order_id: session_order.id, book_id: book.id) }
    let!(:item1) { create(:line_item, quantity: 1, order_id: current_order_user.id, book_id: book.id) }
    subject(:service) { described_class.new(session_order, current_user) }

    it do
      service.call
      expect(current_user.orders.first.line_items.find_by(id: item1.id).quantity).to eq(2)
    end
  end
end
