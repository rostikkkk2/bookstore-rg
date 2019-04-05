class CompletePresenter < Rectify::Presenter
  attribute :params
  attribute :current_order

  def step
    'complete'
  end
end
