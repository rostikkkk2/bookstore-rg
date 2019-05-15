class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :header_presenter

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def header_presenter
    @header_presenter = HeaderPresenter.new(current_order: current_order)
  end

  def not_fount
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def current_order
    Order.find_by(id: cookies[:current_order_id])
  end
end
