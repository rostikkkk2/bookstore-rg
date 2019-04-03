class ConfirmPresenter < Rectify::Presenter
  attribute :params
  attribute :current_order

  def step
    'confirm'
  end
end
