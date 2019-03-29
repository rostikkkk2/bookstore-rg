class CheckoutUpdateService
  attr_reader :params, :current_order, :current_user, :billing_form, :shipping_form, :form

  def initialize(params, current_order, current_user)
    @params = params
    @current_order = current_order
    @current_user = current_user
  end

  def update_step
    checkout_address_right? if params[:step] == 'address'
  end

  def checkout_address_right?
    address_service = AddressService.new(params, current_user, current_order)
    return true if address_service.checkout_call

    @billing_form = address_service.billing
    @shipping_form = address_service.shipping
    false
  end

  def go_to_next_step
    current_order.delivery! && 'delivery' if current_order.address?
  end

  def current_presenter
    if current_order.address?
      return AddressPresenter.new(params: params, current_order: current_order, billing_form: billing_form, shipping_form: shipping_form).attach_controller(self)
    end
    return DeliveryPresenter.new(params: params, current_order: current_order) if current_order.delivery?
  end
end
