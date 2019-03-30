class CheckoutShowService
  attr_reader :params, :current_order, :current_user

  def initialize(params, current_order, current_user)
    @params = params
    @current_order = current_order
    @current_user = current_user
    go_first_step
  end

  def go_first_step
    current_order.address! if current_order.cart?
  end

  def current_presenter
    choosen_step = Order.statuses[params[:step]]
    choose_presenter if choosen_step && choosen_step <= Order.statuses[current_order.status]
  end

  def choose_presenter
    case params[:step]
    when 'address' then AddressPresenter.new(params: params, current_order: current_order).attach_controller(self)
    when 'delivery' then DeliveryPresenter.new(params: params, current_order: current_order).attach_controller(self)
    when 'payment' then PaymentPresenter.new(params: params, current_order: current_order).attach_controller(self)
    end
  end
end
