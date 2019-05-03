class OrdersDecorator < Draper::CollectionDecorator
  START_PRICE = 0

  def coupon_price(order)
    order.coupon ? order.coupon.discount : START_PRICE
  end

  def order_summary_price(order)
    take_line_items_prise(order) + order.delivery.price - coupon_price(order)
  end

  def take_line_items_prise(order)
    order.line_items.map { |item| item.quantity * item.book.price }.sum
  end

  def current_status_order(params)
    I18n.t("orders.#{params[:sort_order_by].to_sym}") if params[:sort_order_by] && OrderSortingService::SORT_BY.include?(params[:sort_order_by].to_sym)
  end
end
