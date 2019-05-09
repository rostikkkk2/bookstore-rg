require 'rails_helper'

RSpec.describe PaymentService do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }

  describe 'create card success' do
    let(:params) { { credit_card_form: { order_id: order.id, number: "3333333333333333", name: "universal", date: "12/21", cvv: 333 } } }
    subject(:service) { described_class.new(params, user, order) }

    it do
      expect(service.call).to eq(true)
      expect(CreditCard.first.order_id).to eq(order.id)
    end
  end

  describe 'create card failed' do
    let(:params) { { credit_card_form: { order_id: order.id, number: '', name: '', date: '' } } }
    subject(:service) { described_class.new(params, user, order) }

    it do
      expect(service.call).to eq(nil)
      expect(CreditCard.all).to eq([])
    end
  end
end
