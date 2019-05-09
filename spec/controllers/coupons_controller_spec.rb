require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  let!(:order) { create(:order) }
  let!(:coupon) { create(:coupon) }

  before { allow(subject).to receive(:current_order).and_return(order) }

  describe 'PUT #update' do
    it 'success' do
      put :update, params: { coupon: coupon.key, id: order.id }
      allow(subject).to receive(:update).and_return(true)
      expect(subject).to redirect_to carts_path
    end

    it 'failed' do
      put :update, params: { coupon: '', id: order.id }
      expect(subject).to set_flash[:error]
      expect(subject).to redirect_to carts_path
    end
  end
end
