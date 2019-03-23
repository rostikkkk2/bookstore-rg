class CheckoutShowService

  attr_reader :params, :current_order, :current_user

  def initialize(params, current_order, current_user)
    @params = params
    @current_order = current_order
    @current_user = current_user
  end

  # def call
  #
  # end

  def current_state
    if current_order.cart?
      current_order.address!
    end
    current_order.status
  end

  def current_presenter
    AddressPresenter.new(current_user: current_user, current_order: current_order).attach_controller(self)
  end
end
