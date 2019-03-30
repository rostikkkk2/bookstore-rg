class DeliveryService
  attr_reader :params, :current_order

  def initialize(params, current_order)
    @params = params
    @current_order = current_order
  end

  def call
    current_order.update(delivery_id: params[:delivery_id])
  end
end
