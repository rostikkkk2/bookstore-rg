class LineItemsController < ApplicationController
  SUCCESS_ADDED_IN_CART = 'Added in cart'.freeze
  DELETE_FROM_CART = 'Successful delete book from cart'.freeze

  def create
    cart_form = CartForm.new(params_request)
    create_order(cart_form)
    CartCreateService.new(current_order, cart_form, params).call
    redirect_message(SUCCESS_ADDED_IN_CART, :success)
  end

  def create_order(cart_form)
    return if current_order && !current_order.complete?
    return cart_form.create_order if current_user

    session[:current_order] = cart_form.create_order
  end

  def destroy
    drop_item_and_empty_order = CartDeleteService.new(current_order, params).call
    current_order.delete && session.delete(:current_order) if drop_item_and_empty_order
    redirect_message(DELETE_FROM_CART, :success)
  end

  def update
    CartUpdateService.new(params).call
    respond_to { |format| format.html { redirect_to cart_path } }
  end

  private

  def redirect_message(message, type)
    redirect_to request.referrer
    flash[type] = message
  end

  def params_request
    params.permit(:current_user, :current_book, :count_books)
  end
end
