class OrdersController < ApplicationController
  authorize_resource

  def index
    current_orders = current_user.orders.complete
    @order_presenter = OrderPresenter.new(current_orders: current_orders, params: params)
    @sort_orders = OrderSortingService.new(params, current_user).call
  end

  def show
    order = Order.find_by(id: params[:id])
    @order_presenter = OrderPresenter.new(current_order: order)
    @cart_presenter = CartPresenter.new(current_order: order)
  end
end
