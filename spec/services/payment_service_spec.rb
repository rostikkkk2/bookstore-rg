require 'rails_helper'

RSpec.describe PaymentService do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  let(:final_count_card) { 1 }

  describe 'create card success' do
    subject(:service) { described_class.new(params, user, order) }

    let(:params) { { credit_card_form: { order_id: order.id, number: '3333333333333333', name: 'universal', date: '12/21', cvv: 333 } } }

    it 'when card create' do
      expect { service.call }.to change(CreditCard, :count).from(0).to(final_count_card)
    end
  end

  describe 'create card failed' do
    subject(:service) { described_class.new(params, user, order) }

    let(:params) { { credit_card_form: { order_id: order.id, number: '', name: '', date: '' } } }

    it 'when card not create' do
      expect(service.call).to eq(nil)
      expect(CreditCard.all).to eq([])
    end
  end
end
