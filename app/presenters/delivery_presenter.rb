class DeliveryPresenter < Rectify::Presenter
  attribute :params
  attribute :current_order

  def step
    'fill_delivery'
  end

  def check_exists_delivery(id)
    return true if current_order.delivery_id == id
  end
end
