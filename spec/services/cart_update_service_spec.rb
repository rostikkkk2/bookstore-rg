require 'rails_helper'

RSpec.describe CartUpdateService do
  let(:current_user) { create(:user) }
  let(:order) { create(:order) }

  describe 'item update success' do
    subject(:service) { described_class.new(params) }

    let(:final_quantity_item) { 2 }
    let(:params) { { quantity_books: 1, plus: true, id: order.line_items.first.id } }

    it 'update item' do
      expect { service.call }.to change { order.line_items.first.quantity }.from(params[:quantity_books]).to(final_quantity_item)
    end
  end

  describe 'item update failed' do
    subject(:service) { described_class.new(params) }

    let(:final_quantity_item) { 1 }
    let(:item) { create(:line_item, order_id: order.id, quantity: -5) }
    let(:params) { { id: item.id } }

    it 'not update item' do
      expect(service.call).to eq(nil)
      expect(order.line_items.first.quantity).to eq(final_quantity_item)
    end
  end
end
