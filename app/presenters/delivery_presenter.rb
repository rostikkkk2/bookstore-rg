class DeliveryPresenter < Rectify::Presenter
  attribute :params
  attribute :current_order

  def step
    'delivery'
  end
end
