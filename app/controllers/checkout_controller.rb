class CheckoutController < ApplicationController
  def show
    @checkout_service = CheckoutShowService.new(params, current_order, current_user)
    @presenter = @checkout_service.current_presenter
  end

  def update
    @checkout_service = CheckoutUpdateService.new(params, current_order, current_user)
    return redirect_to checkout_path(step: @checkout_service.go_to_next_step) if @checkout_service.update_step

    @presenter = @checkout_service.current_presenter
    render :show
  end
end
