class CartPresenter < Rectify::Presenter
  def subtotal_prise_book(book)
    book.price * LineItem.find_by(book_id: book.id).quantity
  end

  def order_current_user
    Order.find_by(user_id: current_user.id)
  end

  def current_line_items
    LineItem.where(order_id: order_current_user)
  end

  def take_book_price_from_item(item)
    Book.find_by(id: item.book_id).price
  end

  def order_summary_price
    item_quantities = current_line_items.map do |item|
      item.quantity * take_book_price_from_item(item)
    end
    item_quantities.sum
  end

  def order_total_price_with_coupon
    order_summary_price
  end

  def count_same_books(book)
    LineItem.find_by(book_id: book.id).quantity
  end

end
