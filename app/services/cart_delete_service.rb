class CartDeleteService
  attr_reader :current_order, :params

  def initialize(current_order, params)
    @current_order = current_order
    @params = params
  end

  def call
    delete_item
    items_current_order.empty?
  end

  def items_current_order
    LineItem.where(order_id: current_order.id)
  end

  def delete_item
    LineItem.find_by(book_id: params[:book_to_destroy].to_i, order_id: current_order.id).delete
  end
end
