class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @cart_presenter = CartPresenter.new(current_order: current_order).attach_controller(self)
    @books_cart = take_current_books_in_cart if current_order
  end

  private

  def take_current_books_in_cart
    line_items = LineItem.where(order_id: current_order.id).order(:id) if current_order
    line_items.map { |item| Book.find_by(id: item.book_id) }
  end
end
