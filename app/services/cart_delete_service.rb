class CartDeleteService
  attr_reader :current_order, :params

  def initialize(current_order, params)
    @current_order = current_order
    @params = params
  end

  def call
    delete_item
    delete_coupon_from_order if current_order.line_items.empty?
  end

  def delete_item
    LineItem.find_by(book_id: params[:id].to_i, order_id: current_order.id).delete
  end

  def delete_coupon_from_order
    current_order.coupon&.update(order_id: nil)
  end
end
