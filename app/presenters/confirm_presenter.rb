class ConfirmPresenter < Rectify::Presenter
  attribute :params
  attribute :current_order

  SECRET_NUMS_FOR_CARD = '**** **** **** '.freeze
  COUNT_NUMS_CARD_SHOW = 4

  def step
    'confirm'
  end

  def current_delivery
    Delivery.find_by(id: current_order.delivery_id).method
  end

  def credit_card_number
    SECRET_NUMS_FOR_CARD + lash_four_nums_card
  end

  def current_line_items
    current_order.line_items
  end

  def lash_four_nums_card
    current_order.credit_card.number.chars.last(COUNT_NUMS_CARD_SHOW).join
  end
end
