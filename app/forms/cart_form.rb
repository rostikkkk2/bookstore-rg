class CartForm
  include ActiveModel::Model
  include Virtus

  attribute :current_user, Integer
  attribute :current_book, Integer
  attribute :count_books, Integer

  validates :current_user, presence: true
  validates :count_books, presence: true, length: { maximum: 10 }
  validates :current_book, presence: true

  def save
    create_order if !exist_order_for_user && valid?
    create_line_item if valid?
  end

  def increment_quantity_book(book)
    book.quantity += count_books
    book.save
  end

  private

  def exist_order_for_user
    Order.find_by(user_id: current_user)
  end

  def create_order
    new_order ||= Order.new(user_id: current_user)
    new_order.save!
  end

  def create_line_item
    new_line_item = LineItem.new(
      book_id: current_book,
      order_id: Order.find_by(user_id: current_user).id,
      quantity: count_books
    )
    new_line_item.save!
  end
end
