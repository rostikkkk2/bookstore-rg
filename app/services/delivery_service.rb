class DeliveryService
  attr_reader :params, :current_user, :current_order

  def initialize(params, current_user, current_order)
    @params = params
    @current_user = current_user
    @current_order = current_order
  end

  def call
    current_order&.update(delivery_id: params[:delivery_id])
  end

  def presenter
    DeliveryPresenter.new(params: params, current_order: current_order)
  end
end
