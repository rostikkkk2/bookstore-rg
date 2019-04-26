class MergeItemsCartService
  attr_reader :session_order, :current_user, :exist_user_order, :user_order

  def initialize(session_order, current_user)
    @session_order = session_order
    @current_user = current_user
    @exist_user_order = current_user.orders.order(:updated_at).last
    @user_order = exist_user_order if exist_user_order && !exist_user_order.complete?
  end

  def call
    return change_items_order_id_to_current if user_order

    session_order.update(user_id: current_user.id)
  end

  def change_items_order_id_to_current
    session_order.line_items.each do |line_item|
      same_item = find_same_item(line_item)
      same_item ? add_quantity_to_save_book(same_item, line_item) : change_current_item_order_id(line_item)
    end
  end

  def find_same_item(line_item)
    user_order.line_items.find_by(book_id: line_item.book_id)
  end

  def change_current_item_order_id(line_item)
    line_item.order_id = user_order.id
    line_item.save
  end

  def add_quantity_to_save_book(same_item, line_item)
    same_item.quantity += line_item.quantity
    same_item.save
    line_item.delete
  end
end
