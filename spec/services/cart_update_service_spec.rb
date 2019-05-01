require 'rails_helper'

RSpec.describe CartUpdateService do
  let(:current_user) { create(:user) }
  let(:order) { create(:order) }

  describe 'item update success' do
    let(:params) { { quantity_books: 1, plus: true, id: order.line_items.first.id } }
    subject(:service) { described_class.new(params) }

    it do
      expect(service.call).to eq(true)
    end
  end

  describe 'item update failed' do
    let(:item) { create(:line_item, order_id: order.id, quantity: -5) }
    let(:params) { {id: item.id } }
    subject(:service) { described_class.new(params) }

    it do
      expect(service.call).to eq(nil)
    end
  end
end
