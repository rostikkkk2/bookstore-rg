class CheckoutController < ApplicationController

  def show
    checkout_service = CheckoutShowService.new(params, current_order, current_user)
    # if checkout_service.success?
      @presenter = checkout_service.current_presenter
      @checkout_presenter = CheckoutPresenter.new(current_step: checkout_service.current_state).attach_controller(self)
      # render 'checkout/address'
    # else
      # redirect_to :show, step: checkout_service.available_step
    # end
      @shipping = AddressForm.new
      @billing = AddressForm.new
    # end
  end

  def update
    @checkout_service = CheckoutUpdateService.new(params, current_order, current_user)
    if @checkout_service.update_step
      # @checkout_service.go_to_next_step

      redirect_to checkout_path
    else
      # @presenter = checkout_service.current_presenter
      @presenter = @checkout_service.current_presenter
      @checkout_presenter = CheckoutPresenter.new(current_step: :address).attach_controller(self)
      @billing = @checkout_service.billing_form
      @shipping = @checkout_service.shipping_form
      render :show
    end
  end
end
