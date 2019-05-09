require 'rails_helper'

RSpec.describe PaymentService do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }

  describe 'create card success' do
    subject(:service) { described_class.new(params, user, order) }

    let(:params) { { credit_card_form: { order_id: order.id, number: '3333333333333333', name: 'universal', date: '12/21', cvv: 333 } } }

    it do
      expect(service.call).to eq(true)
      expect(CreditCard.first.order_id).to eq(order.id)
    end
  end

  describe 'create card failed' do
    subject(:service) { described_class.new(params, user, order) }

    let(:params) { { credit_card_form: { order_id: order.id, number: '', name: '', date: '' } } }

    it do
      expect(service.call).to eq(nil)
      expect(CreditCard.all).to eq([])
    end
  end
end
