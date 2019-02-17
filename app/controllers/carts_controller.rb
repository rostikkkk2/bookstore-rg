class CartsController < ApplicationController
  SUCCESS_ADDED_IN_CART = 'Added in cart'.freeze
  DELETE_FROM_CART = 'Successful delete book from cart'.freeze

  def show
    @cart_presenter = CartPresenter.new.attach_controller(self)
    if user_signed_in? && @cart_presenter.order_current_user
      @books_cart = take_current_books_in_cart
    else
      #session
    end
  end

  def create
    book_in_card = LineItem.find_by(book_id: params[:current_book].to_i)
    if user_signed_in?
      cart_form = CartForm.new(params_request)
      book_in_card && cart_form.valid? ? cart_form.increment_quantity_book(book_in_card) : cart_form.save
      redirect_with_success_message(SUCCESS_ADDED_IN_CART)
    else
      # session
    end
  end

  def destroy
    @cart_presenter = CartPresenter.new.attach_controller(self)
    LineItem.find_by(book_id: params[:book_to_destroy].to_i).delete
    redirect_with_success_message(DELETE_FROM_CART)
    @cart_presenter.order_current_user.delete if @cart_presenter.current_line_items.empty?
  end

  private

  def take_current_books_in_cart
    current_order_user = Order.find_by(user_id: current_user.id)
    line_items = LineItem.where(order_id: current_order_user.id)
    line_items.map { |item| Book.find_by(id: item.book_id) }
  end

  def redirect_with_success_message(message)
    redirect_to request.referrer
    flash[:success] = message
  end

  def params_request
    params.permit(:current_book, :current_user, :count_books)
  end
end
