class OrdersController < ApplicationController
  authorize_resource
  decorates_assigned :order

  def index
    @sort_orders = OrderSortingService.new(params, current_user).call
    @order_presenter = OrderPresenter.new(params: params)
  end

  def show
    @order = Order.find_by(id: params[:id])
    @cart_presenter = CartPresenter.new(current_order: @order)
  end
end
