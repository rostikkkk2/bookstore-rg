class ApplicationController < ActionController::Base
  before_action :home_page, :check_order_on_merge

  def home_page
    @header_presenter = HeaderPresenter.new(current_order: current_order).attach_controller(self)
    @presenter = BooksPresenter.new.attach_controller(self)
  end

  def not_fount
    render file: "#{Rails.root}/public/404.html"
  end

  def check_order_on_merge
    return unless user_signed_in? && session[:current_order]

    MergeItemsCartService.new(session[:current_order], current_user).call
    session.delete(:current_order)
  end

  def current_order
    return Order.find_by(user_id: current_user.id) if user_signed_in?

    Order.find_by(id: session[:current_order]['id']) if session[:current_order]
  end
end
