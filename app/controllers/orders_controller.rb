class OrdersController < ApplicationController
  authorize_resource

  def index
    current_orders = Order.where(user_id: current_user.id, status: 'complete')
    @order_presenter = OrderPresenter.new(current_orders: current_orders).attach_controller(self)
  end

  def show
    order = Order.find_by(id: params[:id])
    @order_presenter = OrderPresenter.new(current_order: order)
    @cart_presenter = CartPresenter.new(current_order: order)
  end
end
