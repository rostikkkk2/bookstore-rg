require 'rails_helper'

RSpec.describe CartDeleteService do
  let(:current_user) { create(:user) }
  let(:current_order) { create(:order, user_id: current_user.id) }

  describe 'item delete success' do
    subject(:service) { described_class.new(current_order, params_success) }

    let(:params_success) { { id: current_order.line_items.first.id } }

    it do
      expect(Order.all).to eq([])
      expect(service.call).to eq(current_order.line_items.first)
    end
  end

  describe 'item delete failed' do
    subject(:service) { described_class.new(current_order, params_failed) }

    let(:params_failed) { { id: current_order.line_items.first.id } }

    it do
      expect(Order.all).to eq([current_order])
      expect(service.call).to eq(nil)
    end
  end
end
