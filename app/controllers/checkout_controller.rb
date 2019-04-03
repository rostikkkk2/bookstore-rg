class CheckoutController < ApplicationController
  def show
    checkout_service = CheckoutShowService.new(params, current_order, current_user)
    @cart_presenter = CartPresenter.new(current_order: current_order).attach_controller(self)
    @presenter = checkout_service.current_presenter || redirect_to(step: current_order.status)
  end

  def update
    checkout_service = CheckoutUpdateService.new(params, current_order, current_user)
    return redirect_to checkout_path(step: checkout_service.go_to_next_step) if checkout_service.update_step

    render_show_with_presenters(checkout_service)
  end

  def render_show_with_presenters(checkout_service)
    @cart_presenter = CartPresenter.new(current_order: current_order).attach_controller(self)
    @presenter = checkout_service.current_presenter
    render :show
  end
end
