class HeaderPresenter < Rectify::Presenter
  attribute :current_order

  def count_books_in_cart
    return 0 unless current_order
    return 0 if current_order.complete?

    current_order.line_items.map(&:quantity).sum
  end
end
