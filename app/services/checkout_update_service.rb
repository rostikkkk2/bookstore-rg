class CheckoutUpdateService
  attr_reader :params, :current_order, :current_user, :billing_form, :shipping_form

  def initialize(params, current_order, current_user)
    @params = params
    @current_order = current_order
    @current_user = current_user
  end

  def update_step
    checkout_address if current_order.address?
  end

  def checkout_address
    @address_service = AddressService.new(params, current_user)
    if @address_service.checkout_call
      true
    else
      @billing_form = @address_service.billing
      @shipping_form = @address_service.shipping
      false 
    end
  end

  def current_presenter
    AddressPresenter.new(params: params, current_user: current_user, current_order: current_order).attach_controller(self)
  end
end
