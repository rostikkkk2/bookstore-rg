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
    return show_complete_presenter if current_order.complete?

    choose_presenter if choosen_step && choosen_step <= Order.statuses[current_order.status]
  end

  def show_complete_presenter
    CompletePresenter.new(params: params, current_order: current_order).attach_controller(self) if params[:step] == 'complete'
  end

  def choose_presenter
    case params[:step]
    when 'address' then AddressPresenter.new(params: params, current_order: current_order).attach_controller(self)
    when 'delivery' then DeliveryPresenter.new(params: params, current_order: current_order).attach_controller(self)
    when 'payment' then PaymentPresenter.new(params: params, current_order: current_order).attach_controller(self)
    when 'confirm' then ConfirmPresenter.new(params: params, current_order: current_order).attach_controller(self)
    end
  end
end
