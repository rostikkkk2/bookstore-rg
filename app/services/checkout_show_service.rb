class CheckoutShowService
  attr_reader :params, :current_order, :current_user
  BEGIN_SECRET_NUMBER = '#R'.freeze
  LENGTH_SECRET_NUMBER = 13
  RANGE_SECRET_NUMBER = (0..9).freeze

  def initialize(params, current_order, current_user)
    @params = params
    @current_order = current_order
    @current_user = current_user
    go_first_step
  end

  def go_first_step
    create_secret_key unless current_order.number
    current_order.address! if current_order.cart?
  end

  def create_secret_key
    current_order.update(number: generate_order_secret_number)
  end

  def generate_order_secret_number
    Array.new(LENGTH_SECRET_NUMBER) { [rand(RANGE_SECRET_NUMBER)] }.unshift(BEGIN_SECRET_NUMBER).join
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
