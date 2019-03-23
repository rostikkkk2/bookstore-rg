class CheckoutPresenter < Rectify::Presenter
  attribute :current_step

  def partial_name
    "checkout/#{current_step}"
  end
end
