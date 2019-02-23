class CartPresenter < Rectify::Presenter
  attribute :current_order

  def subtotal_prise_book(book)
    book.price * LineItem.find_by(book_id: book.id, order_id: current_order).quantity
  end

  def current_line_items
    LineItem.where(order_id: current_order.id)
  end

  def take_book_price_from_item(item)
    Book.find_by(id: item.book_id).price
  end

  def order_summary_price
    item_quantities = current_line_items.map { |item| item.quantity * take_book_price_from_item(item) }
    item_quantities.sum
  end

  def order_total_price_with_coupon
    order_summary_price
  end

  def count_same_books(book)
    LineItem.find_by(book_id: book.id, order_id: current_order.id).quantity
  end
end
