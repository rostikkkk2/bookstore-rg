require 'rails_helper'

RSpec.describe ConfirmService do
  let(:user) { create(:user) }
  let(:order) { create(:order, :payment_step) }

  describe 'confirm success' do
    subject(:service) { described_class.new(params, user, order) }

    let(:params) { { user_id: user.id } }

    it do
      expect(service.call).to eq(true)
      expect(order.number).not_to eq(nil)
    end
  end

  describe 'confirm failed' do
    subject(:service) { described_class.new(params, user, nil) }

    let(:params) { { user_id: user.id } }

    it do
      expect(service.call).to eq(nil)
      expect(order.status).to eq(:payment.to_s)
    end
  end
end
