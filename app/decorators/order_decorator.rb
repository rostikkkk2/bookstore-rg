class OrderDecorator < Draper::Decorator
  delegate_all
  COUNT_NUMS_CARD_SHOW = 4
  SECRET_NUMS_FOR_CARD = '**** **** **** '.freeze

  def lash_four_nums_card
    object.credit_card.number.chars.last(COUNT_NUMS_CARD_SHOW).join
  end
end
