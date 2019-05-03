class CartCreateService
  attr_reader :current_order, :cart_form, :params, :current_user

  def initialize(current_user, params_request, params)
    @current_user = current_user
    @cart_form = CartForm.new(params_request)
    @params = params
  end

  def call(current_order)
    @current_order = current_order
    create_item
  end

  def create_item
    current_exist_item ? increment_quantity_book(current_exist_item) : save_item
  end

  def current_exist_item
    current_order.line_items.find_by(book_id: params[:current_book].to_i)
  end

  def increment_quantity_book(book)
    book.quantity += params[:count_books].to_i
    book.save
  end

  def save_item
    create_line_item if cart_form.valid?
  end

  def create_order
    new_order ||= Order.new
    new_order.save
    new_order
  end

  private

  def create_line_item
    LineItem.new(
      book_id: cart_form.current_book,
      order_id: current_order.id,
      quantity: cart_form.count_books
    ).save
  end
end
