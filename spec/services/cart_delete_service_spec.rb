require 'rails_helper'

RSpec.describe CartDeleteService do
  let(:current_user) { create(:user) }
  let!(:current_order) { create(:order, user_id: current_user.id) }
  let(:count_item) { 1 }

  describe 'item delete success' do
    subject(:service) { described_class.new(current_order, params_success) }

    let(:params_success) { { id: current_order.line_items.first.id } }

    it 'delete success' do
      expect { service.call }.to change(LineItem, :count).from(count_item).to(0)
    end
  end

  describe 'item delete failed' do
    subject(:service) { described_class.new(current_order, params_failed) }

    let(:params_failed) { { id: current_order.line_items.first.id } }

    it 'not delete' do
      expect(Order.all).to eq([current_order])
      expect(service.call).to eq(nil)
    end
  end
end
