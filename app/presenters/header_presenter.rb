class HeaderPresenter < Rectify::Presenter
  def order_current_user
    Order.find_by(user_id: current_user.id)
  end

  def all_line_items_user
    LineItem.where(order_id: order_current_user)
  end

  def count_books_in_cart
    if user_signed_in?
      item_quantities = all_line_items_user.map(&:quantity)
      item_quantities.sum
    else
      0
    end
  end
end
