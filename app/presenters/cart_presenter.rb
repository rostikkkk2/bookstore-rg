class CartPresenter < Rectify::Presenter
  attribute :current_order
  START_PRICE = 0

  def subtotal_prise_book(book)
    book.price * count_same_books(book)
  end

  def order_summary_price
    current_order.line_items.sum { |item| item.quantity * item.book.price }
  end

  def order_total_price_with_coupon
    order_summary_price + delivery_price - coupon_discount
  end

  def coupon_discount
    current_order.coupon ? current_order.coupon.discount : START_PRICE
  end

  def count_same_books(book)
    current_order.line_items.find_by(book: book).quantity
  end

  def delivery_price
    current_order.delivery_id ? current_order.delivery.price : START_PRICE
  end
end
