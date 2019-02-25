class CartForm
  include ActiveModel::Model
  include Virtus

  attribute :current_user, Integer
  attribute :current_book, Integer
  attribute :count_books, Integer

  validates :count_books, presence: true, length: { maximum: 10 }
  validates :current_book, presence: true

  def save(order_session_id = nil)
    create_line_item(order_session_id) if valid?
  end

  def create_order
    new_order ||= Order.new(user_id: current_user)
    new_order.save
    new_order
  end

  private

  def create_line_item(order_id)
    new_line_item = LineItem.new(
      book_id: current_book,
      order_id: order_id,
      quantity: count_books
    )
    new_line_item.save
  end
end
