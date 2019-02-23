class HeaderPresenter < Rectify::Presenter
  attribute :current_order

  def all_line_items_user
    LineItem.where(order_id: current_order)
  end

  def count_books_in_cart
    return 0 unless current_order

    item_quantities = all_line_items_user.map(&:quantity)
    item_quantities.sum
  end
end
