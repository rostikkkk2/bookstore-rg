class CartCreateService
  attr_reader :current_order, :cart_form, :params

  def initialize(current_order, cart_form, params)
    @current_order = current_order
    @cart_form = cart_form
    @params = params
  end

  def call
    create_item
  end

  def create_item
    current_exist_item ? increment_quantity_book(current_exist_item) : cart_form.save(current_order.id)
  end

  def current_exist_item
    LineItem.find_by(book_id: params[:current_book].to_i, order_id: current_order.id)
  end

  def increment_quantity_book(book)
    book.quantity += params[:count_books].to_i
    book.save
  end
end
