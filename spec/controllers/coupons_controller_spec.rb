require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  let!(:order) { create(:order) }
  let!(:coupon) { create(:coupon) }

  describe 'PUT #update' do
    # it 'success' do
    #   put :update, params: { coupon: coupon.key, id: order.id }
    #   allow(Coupon).to receive(:find_by).and_return(coupon)
    #   # expect_any_instance_of(Coupon).to receive(:update).with(order_id: order.id)
    #   # allow_any_instance_of(Coupon).to receive(:update).with(order_id: order.id).and_return(true)
    #   is_expected.to redirect_to carts_path
    # end

    it 'failed' do
      put :update, params: { coupon: '', id: order.id }
      allow(Coupon).to receive(:find_by).and_return([])
      # is_expected.to flash[:error]
      is_expected.to redirect_to carts_path
    end
  end
end
