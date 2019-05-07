class PaymentPresenter < Rectify::Presenter
  attribute :params
  attribute :current_order
  attribute :form
  STEP = :payment

  def payment_card
    form || CreditCardForm.new
  end

  def current_card
    current_order.credit_card
  end

  def check_exists_errors(type)
    'has-error' unless payment_card.errors[type].empty?
  end
end
