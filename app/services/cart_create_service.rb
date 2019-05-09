class CartCreateService
  attr_reader :order, :cart_form, :params, :current_user

  def initialize(current_user, params_request, params)
    @current_user = current_user
    @cart_form = CartForm.new(params_request)
    @params = params
  end

  def call(current_order)
    @order = current_order
    create_item
  end

  def create_item
    current_exist_item ? increment_quantity_book(current_exist_item) : save_item
  end

  def current_exist_item
    order.line_items.find_by(book_id: params[:current_book].to_i)
  end

  def increment_quantity_book(book)
    book.quantity += params[:count_books].to_i
    book.save
  end

  def save_item
    create_line_item if cart_form.valid?
  end

  def create_order
    Order.create
  end

  private

  def create_line_item
    order.line_items.create(book_id: cart_form.current_book, quantity: cart_form.count_books)
  end
end
