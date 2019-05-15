class QuickRegistrationPresenter < Rectify::Presenter
  attribute :params
  attribute :current_order
  STEP = :quick_registrate
end
