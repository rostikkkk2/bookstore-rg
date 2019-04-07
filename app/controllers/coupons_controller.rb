class CouponsController < ApplicationController
  ERROR_COUPON = 'wrong coupon'.freeze

  def update
    coupon = Coupon.find_by(key: params[:coupon])
    coupon && !coupon.used ? coupon.update(order_id: current_order.id) : flash[:error] = ERROR_COUPON
    redirect_to carts_path
  end
end
