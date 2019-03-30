class CheckoutUpdateService
  attr_reader :params, :current_order, :current_user, :billing_form, :shipping_form, :form
  TYPES_CHECKOUT = {
    address: ->(instance) { instance.checkout_address_right? },
    delivery: ->(instance) { instance.checkout_delivery_right? },
    payment: ->(instance) { instance.checkout_payment_right? }
  }.freeze

  def initialize(params, current_order, current_user)
    @params = params
    @current_order = current_order
    @current_user = current_user
  end

  def update_step
    TYPES_CHECKOUT[params[:step].to_sym].call(self)
  end

  def checkout_address_right?
    address_service = AddressService.new(params, current_user, current_order)
    return true if address_service.checkout_call

    @billing_form = address_service.billing
    @shipping_form = address_service.shipping
    false
  end

  def checkout_delivery_right?
    DeliveryService.new(params, current_order).call
  end

  def go_to_next_step
    if params[:step] == current_order.status
      return current_order.delivery! && 'delivery' if current_order.address?
      return current_order.payment! && 'payment' if current_order.delivery?
    end
  end

  def current_presenter
    case params[:step]
    when 'address' then AddressPresenter.new(params: params, current_order: current_order, billing_form: billing_form, shipping_form: shipping_form).attach_controller(self)
    when 'delivery' then DeliveryPresenter.new(params: params, current_order: current_order).attach_controller(self)
    when 'payment' then PaymentPresenter.new(params: params, current_order: current_order).attach_controller(self)
    end
  end
end
