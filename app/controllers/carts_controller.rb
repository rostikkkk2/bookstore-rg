class CartsController < ApplicationController
  SUCCESS_ADDED_IN_CART = 'Added in cart'.freeze

  def show
    if user_signed_in?
      @books_cart = take_current_books_in_cart
    else
      #session
    end
    @cart_presenter = CartPresenter.new.attach_controller(self)
  end

  def create
    book_in_card = LineItem.find_by(book_id: params[:current_book].to_i)
    if user_signed_in?
      cart_form = CartForm.new(params_request)
      book_in_card && cart_form.valid? ? cart_form.increment_quantity_book(book_in_card) : cart_form.save
      redirect_with_success_message
    else
      # session
    end
  end

  private

  def take_current_books_in_cart
    current_order_user = Order.find_by(user_id: current_user.id)
    line_items = LineItem.where(order_id: current_order_user.id)
    line_items.map { |item| Book.find_by(id: item.book_id) }
  end

  def redirect_with_success_message
    redirect_to request.referrer
    flash[:success] = SUCCESS_ADDED_IN_CART
  end

  def params_request
    params.permit(:current_book, :current_user, :count_books)
  end
end
