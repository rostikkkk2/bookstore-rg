class ApplicationController < ActionController::Base
  before_action :application

  def application
    @categories = Category.all
  end
end
