class CheckoutUpdateService
  attr_reader :params, :current_order, :current_user, :presenter

  SERVICES = {
    address: AddressCheckoutService,
    fill_delivery: DeliveryService,
    payment: PaymentService,
    confirm: ConfirmService
  }.freeze

  CHANGE_STEP = {
    address: ->(order) { order.fill_delivery! },
    fill_delivery: ->(order) { order.payment! },
    payment: ->(order) { order.confirm! },
    confirm: ->(order) { order.complete! }
  }.freeze

  def initialize(params, current_order, current_user)
    @params = params
    @current_order = current_order
    @current_user = current_user
  end

  def call
    service = SERVICES[params[:step].to_sym].new(params, current_user, current_order)
    return true if service.call

    @presenter = service.presenter
    false
  end

  def go_to_next_step
    CHANGE_STEP[params[:step].to_sym].call(current_order) if params[:step] == current_order.status
    current_order.status
  end

  def cart_presenter
    CartPresenter.new(current_order: current_order)
  end
end
