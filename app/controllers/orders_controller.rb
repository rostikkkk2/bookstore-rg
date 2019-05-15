class OrdersController < ApplicationController
  authorize_resource

  def index
    @sort_orders = OrderSortingService.new(params, current_user).call
  end

  def show
    find_order = Order.find_by(id: params[:id])
    return redirect_to orders_path unless find_order

    @order = find_order.decorate
    @cart_presenter = CartPresenter.new(current_order: @order)
  end
end
