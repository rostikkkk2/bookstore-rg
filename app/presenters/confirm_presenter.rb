class ConfirmPresenter < Rectify::Presenter
  attribute :params
  attribute :current_order

  SECRET_NUMS_FOR_CARD = '**** **** **** '.freeze
  COUNT_NUMS_CARD_SHOW = 4
  STEP = :confirm

  def lash_four_nums_card
    current_order.credit_card.number.chars.last(COUNT_NUMS_CARD_SHOW).join
  end
end
