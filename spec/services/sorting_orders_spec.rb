require 'rails_helper'

RSpec.describe OrderSortingService do
  let!(:user) { create(:user) }
  let!(:order1) { create(:order, :complete_step, user_id: user.id) }
  let!(:order2) { create(:order, :in_delivery_step, user_id: user.id) }
  let!(:order3) { create(:order, :delivered_step, user_id: user.id) }
  let!(:order4) { create(:order, :canceled_step, user_id: user.id) }

  let(:params_sort_in_progress) { { sort_order_by: :in_progress } }
  let(:params_sort_in_delivery) { { sort_order_by: :in_delivery } }
  let(:params_sort_delivered) { { sort_order_by: :delivered } }
  let(:params_sort_canceled) { { sort_order_by: :canceled } }
  let(:params_without_sort) { { sort_order_by: nil } }

  describe 'sorting orders by in_progress' do
    subject(:service) { described_class.new(params_sort_in_progress, user) }

    it 'when by in_progress' do
      expect(service.call).to eq([order1])
    end
  end

  describe 'sorting orders by in_delivery' do
    subject(:service) { described_class.new(params_sort_in_delivery, user) }

    it 'when by in_delivery' do
      expect(service.call).to eq([order2])
    end
  end

  describe 'sorting orders by delivered' do
    subject(:service) { described_class.new(params_sort_delivered, user) }

    it 'when by delivered' do
      expect(service.call).to eq([order3])
    end
  end

  describe 'sorting orders by canceled' do
    subject(:service) { described_class.new(params_sort_canceled, user) }

    it 'when by canceled' do
      expect(service.call).to eq([order4])
    end
  end

  describe 'sorting orders do not sorted' do
    subject(:service) { described_class.new(params_without_sort, user) }

    it 'when do not sorted' do
      expect(service.call).to eq([order1])
    end
  end
end
