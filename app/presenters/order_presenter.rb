class OrderPresenter < Rectify::Presenter
  attribute :current_orders
  attribute :current_order

  SECRET_NUMS_FOR_CARD = '**** **** **** '.freeze
  COUNT_NUMS_CARD_SHOW = 4

  def total_price(order)
    delivery_price = Delivery.find_by(id: order.delivery_id).price
    order.line_items.map { |item| item.book.price * item.quantity }.join.to_i + delivery_price
  end

  def current_delivery
    Delivery.find_by(id: current_order.delivery_id).method
  end

  def credit_card_number
    SECRET_NUMS_FOR_CARD + lash_four_nums_card
  end

  def lash_four_nums_card
    current_order.credit_card.number.chars.last(COUNT_NUMS_CARD_SHOW).join
  end

  def order_summary_price(order)
    item_quantities = order.line_items.map { |item| item.quantity * item.book.price }
    item_quantities.sum + Delivery.find_by(id: order.delivery_id).price
  end
end
