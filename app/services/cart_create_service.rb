class CartCreateService
  attr_reader :current_order, :cart_form, :params, :current_user

  def initialize(current_user, cart_form, params)
    @current_user = current_user
    @cart_form = cart_form
    @params = params
  end

  def call(current_order)
    @current_order = current_order
    create_item
  end

  def create_order?(order)
    return true if order && !order.complete?

    cart_form.create_order if current_user
  end

  def create_item
    current_exist_item ? increment_quantity_book(current_exist_item) : cart_form.save(current_order.id)
  end

  def current_exist_item
    current_order.line_items.find_by(book_id: params[:current_book].to_i)
  end

  def increment_quantity_book(book)
    book.quantity += params[:count_books].to_i
    book.save
  end
end
