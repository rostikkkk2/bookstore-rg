require 'rails_helper'

RSpec.describe ConfirmService do
  let(:user) { create(:user) }
  let(:order) { create(:order, :payment_step) }

  describe 'confirm success' do
    let(:params) { { user_id: user.id } }
    subject(:service) { described_class.new(params, user, order) }

    it do
      expect(service.call).to eq(true)
      expect(order.number).not_to eq(nil)
    end
  end

  describe 'confirm failed' do
    let(:params) { { user_id: user.id } }
    subject(:service) { described_class.new(params, user, nil) }

    it do
      expect(service.call).to eq(nil)
      expect(order.status).to eq(:payment.to_s)
    end
  end
end
