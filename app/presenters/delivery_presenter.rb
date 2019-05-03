class DeliveryPresenter < Rectify::Presenter
  attribute :params
  attribute :current_order
  STEP = :fill_delivery

  def check_exists_delivery(id)
    return true if current_order.delivery_id == id
  end
end
