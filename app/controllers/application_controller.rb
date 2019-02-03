class ApplicationController < ActionController::Base
  before_action :home_page

  def home_page
    @presenter = BooksPresenter.new.attach_controller(self)
  end

  def not_fount
    render file: "#{Rails.root}/public/404.html"
  end

end
