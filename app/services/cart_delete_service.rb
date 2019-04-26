class CartDeleteService
  attr_reader :current_order, :params

  def initialize(current_order, params)
    @current_order = current_order
    @params = params
  end

  def call
    delete_item
    delete_coupon_from_order if empty_order?
  end

  def delete_order?
    current_order.destroy if empty_order?
  end

  def delete_item
    current_order.line_items.find_by(book_id: params[:id].to_i).delete
  end

  def empty_order?
    current_order.line_items.empty?
  end

  def delete_coupon_from_order
    current_order.coupon&.update(order_id: nil)
  end
end
