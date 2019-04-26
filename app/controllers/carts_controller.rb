class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @cart_presenter = CartPresenter.new(current_order: current_order)
    @cart_books = current_order&.books
  end
end
