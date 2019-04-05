class CartPresenter < Rectify::Presenter
  attribute :current_order

  def subtotal_prise_book(book)
    book.price * LineItem.find_by(book_id: book.id, order_id: current_order).quantity
  end

  def current_line_items
    LineItem.where(order_id: current_order.id)
  end

  def order_summary_price
    item_quantities = current_line_items.map { |item| item.quantity * item.book.price }
    item_quantities.sum
  end

  def order_total_price_with_coupon
    order_summary_price + delivery_price
  end

  def count_same_books(book)
    LineItem.find_by(book_id: book.id, order_id: current_order.id).quantity
  end

  def delivery_price
    current_order.delivery_id ? Delivery.find_by(id: current_order.delivery_id).price : 0
  end
end
