require 'rails_helper'

RSpec.describe DeliveryService do
  let(:user) { create(:user) }
  let(:delivery) { create(:delivery) }
  let(:order) { create(:order, user_id: user.id, delivery_id: nil) }
  let(:params) { { step: 'delivery', delivery_id: delivery.id } }

  describe 'add delivery id to order success' do
    subject(:service) { described_class.new(params, user, order) }

    it 'when add delivery id success' do
      expect { service.call }.to change { order.reload.delivery_id }.from(nil).to(delivery.id)
    end
  end

  describe 'add delivery id to order success' do
    subject(:service) { described_class.new(params, user, nil) }

    it 'when not add delivery id' do
      expect(service.call).to eq(nil)
      expect(order.delivery_id).to eq(nil)
    end
  end
end
