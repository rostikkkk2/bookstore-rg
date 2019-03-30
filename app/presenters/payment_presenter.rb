class PaymentPresenter < Rectify::Presenter
  attribute :params
  attribute :current_order

  def step
    'payment'
  end
end
