class CheckoutShowService
  attr_reader :params, :current_order, :current_user

  def initialize(params, current_order, current_user)
    @params = params
    @current_order = current_order
    @current_user = current_user
    current_state
  end

  def current_state
    ## here define what status
    current_order.address! if current_order.cart?
    current_order.status
  end

  def current_presenter
    if current_order.address?
      return AddressPresenter.new(params: params, current_order: current_order, show_order: true, step: 'address', billing: AddressForm.new, shipping: AddressForm.new).attach_controller(self)
    end
    return DeliveryPresenter.new(params: params, current_order: current_order, step: 'delivery') if current_order.delivery?
  end
end
