class OrdersController < ApplicationController
  authorize_resource

  def index
    @sort_orders = OrderSortingService.new(params, current_user).call
  end

  def show
    return redirect_to orders_path unless params[:id]

    @order = Order.find_by(id: params[:id]).decorate
    @cart_presenter = CartPresenter.new(current_order: @order)
  end
end
