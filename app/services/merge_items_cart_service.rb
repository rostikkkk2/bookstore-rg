class MergeItemsCartService
  attr_reader :session_order, :current_user

  def initialize(session_order, current_user)
    @session_order = session_order
    @current_user = current_user
  end

  def call
    return add_current_order_session_user_id unless Order.find_by(user_id: current_user.id)

    change_items_order_id_to_current
  end

  def add_current_order_session_user_id
    current_order = Order.find_by(id: session_order['id'])
    current_order.user_id = current_user.id
    current_order.save
  end

  def change_items_order_id_to_current
    LineItem.where(order_id: session_order['id']).each do |line_item|
      same_item = find_same_item(line_item)
      same_item ? add_quantity_to_save_book(same_item, line_item) : change_current_item_order_id(line_item)
    end
  end

  def find_same_item(line_item)
    LineItem.find_by(book_id: line_item.book_id, order_id: Order.find_by(user_id: current_user.id).id)
  end

  def change_current_item_order_id(line_item)
    line_item.order_id = Order.find_by(user_id: current_user.id).id
    line_item.save
  end

  def add_quantity_to_save_book(same_item, line_item)
    same_item.quantity += line_item.quantity
    same_item.save
    line_item.delete
  end
end
