class OrderPresenter < Rectify::Presenter
  attribute :current_orders
  attribute :current_order
  attribute :params
  SECRET_NUMS_FOR_CARD = '**** **** **** '.freeze
  COUNT_NUMS_CARD_SHOW = 4
  START_PRICE = 0

  def total_price(order)
    order.line_items.map { |item| item.book.price * item.quantity }.join.to_i + current_delivery(order).price
  end

  def current_delivery(order = nil)
    total_order = order || current_order
    Delivery.find_by(id: total_order.delivery_id)
  end

  def credit_card_number
    SECRET_NUMS_FOR_CARD + lash_four_nums_card
  end

  def lash_four_nums_card
    current_order.credit_card.number.chars.last(COUNT_NUMS_CARD_SHOW).join
  end

  def order_summary_price(order)
    take_line_items_prise_from_order(order).sum + current_delivery(order).price - coupon_price(order)
  end

  def coupon_price(order)
    order.coupon ? order.coupon.discount : START_PRICE
  end

  def take_line_items_prise_from_order(order)
    order.line_items.map { |item| item.quantity * item.book.price }
  end

  def current_status_order
    if params[:sort_order_by] && OrderSortingService::SORT_BY.include?(params[:sort_order_by].to_sym)
      t("orders.#{params[:sort_order_by].to_sym}")
    else
      t('orders.in_progress')
    end
  end
end
