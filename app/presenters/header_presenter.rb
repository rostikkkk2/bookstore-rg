class HeaderPresenter < Rectify::Presenter
  attribute :current_order

  def all_categories
    Category.all
  end

  def count_books_in_cart
    return 0 if current_order&.complete?

    current_order&.line_items&.map(&:quantity)&.sum.to_i
  end
end
