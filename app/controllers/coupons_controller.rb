class CouponsController < ApplicationController
  def update
    coupon = Coupon.find_by(key: params[:coupon])
    coupon ? current_order.update(coupon: coupon) : flash[:error] = I18n.t('controllers.wrong_coupon')
    redirect_to carts_path
  end
end
