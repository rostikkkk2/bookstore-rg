class ApplicationController < ActionController::Base
  before_action :application

  def application
    @categories = Category.all
  end

  def not_fount
    render file: "#{Rails.root}/public/404.html"
  end

end
