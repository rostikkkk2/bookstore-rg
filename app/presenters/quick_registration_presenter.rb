class QuickRegistrationPresenter < Rectify::Presenter
  attribute :params
  attribute :current_order

  def step
    'quick_registrate'
  end
end
