class CheckoutUpdateService
  attr_reader :params, :current_order, :current_user, :billing_form, :shipping_form, :form
  TYPES_CHECKOUT = {
    address: ->(instance) { instance.checkout_address_right? },
    fill_delivery: ->(instance) { instance.checkout_delivery_right? },
    payment: ->(instance) { instance.checkout_payment_right? },
    confirm: ->(instance) { instance.checkout_last_step }
  }.freeze

  CHANGE_STEP = {
    address: ->(order) { Order.checkout_address(order) },
    fill_delivery: ->(order) { Order.checkout_fill_delivery(order) },
    payment: ->(order) { Order.checkout_payment(order) },
    confirm: ->(order) { Order.checkout_confirm(order) }
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
    address_service = AddressCheckoutService.new(params, current_user, current_order)
    return true if address_service.call

    @billing_form = address_service.billing
    @shipping_form = address_service.shipping
    false
  end

  def checkout_delivery_right?
    DeliveryService.new(params, current_order).call
  end

  def checkout_payment_right?
    credit_card_service = PaymentService.new(params, current_user, current_order)
    return true if credit_card_service.call

    @form = credit_card_service.form
    false
  end

  def checkout_last_step
    ConfirmService.new(current_order).call
    OrderMailer.send_thanks_for_order(current_order).deliver_later
  end

  def go_to_next_step
    CHANGE_STEP[params[:step].to_sym].call(current_order) if params[:step] == current_order.status
    current_order.status
  end

  def cart_presenter
    CartPresenter.new(current_order: current_order)
  end

  def current_presenter
    case params[:step]
    when 'address' then AddressPresenter.new(params: params, current_order: current_order, billing_form: billing_form, shipping_form: shipping_form)
    when 'fill_delivery' then DeliveryPresenter.new(params: params, current_order: current_order)
    when 'payment' then PaymentPresenter.new(params: params, current_order: current_order, form: form)
    end
  end
end
