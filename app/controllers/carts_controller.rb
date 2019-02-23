class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token

  SUCCESS_ADDED_IN_CART = 'Added in cart'.freeze
  DELETE_FROM_CART = 'Successful delete book from cart'.freeze

  def show
    @cart_presenter = CartPresenter.new(current_order: current_order).attach_controller(self)
    @books_cart = take_current_books_in_cart if current_order
  end

  def create
    cart_form = CartForm.new(params_request)
    # @cart_service = CartService.new
    if user_signed_in?
      # @cart_service.create_order_and_item
      cart_form.create_order if !Order.find_by(user_id: current_user.id)

      book_in_card = LineItem.find_by(book_id: params[:current_book].to_i, order_id: current_order.id)
      book_in_card ? increment_quantity_book(book_in_card) : cart_form.save
    else
      session[:current_order] = cart_form.create_order if !session[:current_order]

      book_in_card = LineItem.find_by(book_id: params[:current_book].to_i, order_id: current_order.id)
      book_in_card ? increment_quantity_book(book_in_card) : cart_form.save(session[:current_order]['id'])
    end

    redirect_with_success_message(SUCCESS_ADDED_IN_CART)
    # session.delete(:current_order)
  end

  def increment_quantity_book(book)
    book.quantity += params[:count_books].to_i
    book.save
  end

  def destroy
    @cart_presenter = CartPresenter.new(current_order: current_order).attach_controller(self)
    LineItem.find_by(book_id: params[:book_to_destroy].to_i, order_id: current_order.id).delete
    redirect_with_success_message(DELETE_FROM_CART)
    current_order.delete && session.delete(:current_order) if @cart_presenter.current_line_items.empty?
  end

  def update
    line_item = LineItem.find_by(id: params[:id].to_i)
    new_quantity = params[:plus] ? line_item.quantity += 1 : line_item.quantity -= 1
    line_item.update_column(:quantity, new_quantity) if new_quantity > 0
    respond_to do |format|
      format.html { redirect_to cart_path }
    end
  end

  private

  def take_current_books_in_cart
    line_items = if user_signed_in? && current_order
                   LineItem.where(order_id: current_order.id).order(:id)
                 else
                   LineItem.where(order_id: session[:current_order]['id']).order(:id) if session[:current_order]
                 end
    line_items.map { |item| Book.find_by(id: item.book_id) }
  end

  def redirect_with_success_message(message)
    redirect_to request.referrer
    flash[:success] = message
  end

  def params_request
    params.permit(:current_book, :count_books)
  end
end
