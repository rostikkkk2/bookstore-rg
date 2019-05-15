class CheckoutController < ApplicationController
  after_action :clear_order_session, only: [:show]

  def show
    service = CheckoutShowService.new(params, current_order, current_user)
    return redirect_to root_path unless current_order
    return redirect_to(step: current_order.status) unless service.current_presenter

    @cart_presenter = CartPresenter.new(current_order: current_order)
    @presenter = service.current_presenter
  end

  def update
    service = CheckoutUpdateService.new(params.permit!, current_order, current_user)
    return redirect_to checkout_path(step: service.go_to_next_step) if service.call

    @cart_presenter = service.cart_presenter
    @presenter = service.presenter
    render :show
  end

  private

  def clear_order_session
    cookies.delete(:current_order_id) if current_order&.complete?
  end
end
