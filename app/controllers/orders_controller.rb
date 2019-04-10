class OrdersController < ApplicationController
  authorize_resource
  STATUS_COMPLETE = 'complete'.freeze

  def index
    current_orders = Order.where(user_id: current_user.id, status: STATUS_COMPLETE)
    @order_presenter = OrderPresenter.new(current_orders: current_orders).attach_controller(self)
    @sort_orders = OrderSortingService.new(params, current_user).call
  end

  def show
    order = Order.find_by(id: params[:id])
    @order_presenter = OrderPresenter.new(current_order: order)
    @cart_presenter = CartPresenter.new(current_order: order)
  end
end
