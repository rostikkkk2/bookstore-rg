class MergeItemsCartService
  attr_reader :session_order, :current_user, :exist_user_order, :user_order, :same_session_item

  def initialize(session_order, current_user)
    @session_order = session_order
    @current_user = current_user
    @exist_user_order = current_user.orders.order(:updated_at).last
    @user_order = exist_user_order if exist_user_order && !exist_user_order.complete?
  end

  def call
    return move_items_session_to_user_order if user_order

    session_order.update(user_id: current_user.id)
  end

  def move_items_session_to_user_order
    session_order.line_items.each { |item| update_order_id_or_quantity_item(item) }
  end

  def update_order_id_or_quantity_item(item)
    find_same_item(item) ? add_quantity_to_same_book(same_session_item, item) : item.update(order_id: user_order.id)
  end

  def find_same_item(line_item)
    @same_session_item = user_order.line_items.find_by(book_id: line_item.book_id)
  end

  def add_quantity_to_same_book(same_item, line_item)
    same_item.quantity += line_item.quantity
    same_item.save
    line_item.delete
  end
end
