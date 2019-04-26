class CouponsController < ApplicationController
  def update
    coupon = Coupon.find_by(key: params[:coupon])
    coupon && !coupon.used ? coupon.update(order_id: current_order.id) : flash[:error] = I18n.t('controllers.wrong_coupon')
    redirect_to carts_path
  end
end
