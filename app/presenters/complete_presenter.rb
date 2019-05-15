class CompletePresenter < Rectify::Presenter
  attribute :params
  attribute :current_order
  STEP = :complete
end
