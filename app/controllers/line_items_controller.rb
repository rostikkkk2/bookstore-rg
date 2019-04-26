class LineItemsController < ApplicationController
  def create
    cart_form = CartForm.new(params_request)
    cart_service = CartCreateService.new(current_user, cart_form, params)
    session[:current_order_id] = cart_form.create_order.id unless cart_service.create_order?(current_order)
    cart_service.call(current_order)
    redirect_message(I18n.t('controllers.added_in_cart'), :success)
  end

  def destroy
    cart_service = CartDeleteService.new(current_order, params)
    cart_service.call
    session.delete(:current_order_id) if cart_service.delete_order?
    redirect_message(I18n.t('controllers.deleted_from_cart'), :success)
  end

  def update
    CartUpdateService.new(params).call
    respond_to { |format| format.html { redirect_to carts_path } }
  end

  private

  def redirect_message(message, type)
    redirect_back(fallback_location: root_path)
    flash[type] = message
  end

  def params_request
    params.permit(:current_user, :current_book, :count_books)
  end
end
