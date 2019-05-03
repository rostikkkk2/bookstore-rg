class OrdersController < ApplicationController
  authorize_resource

  def index
    @sort_orders = OrderDecorator.decorate_collection(OrderSortingService.new(params, current_user).call)
  end

  def show
    @order = Order.find_by(id: params[:id]).decorate
    @cart_presenter = CartPresenter.new(current_order: @order)
  end
end
