class CheckoutController < ApplicationController
  def show
    checkout_service = CheckoutShowService.new(params, current_order, current_user)
    return redirect_to(step: current_order.status) unless checkout_service.current_presenter

    @cart_presenter = CartPresenter.new(current_order: current_order)
    @presenter = checkout_service.current_presenter
  end

  def update
    checkout_service = CheckoutUpdateService.new(params, current_order, current_user)
    return redirect_to checkout_path(step: checkout_service.go_to_next_step) if checkout_service.call

    @cart_presenter = checkout_service.cart_presenter
    @presenter = checkout_service.presenter
    render :show
  end
end
