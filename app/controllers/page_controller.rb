class PageController < ApplicationController

  def index
    @presenter = BooksPresenter.new.attach_controller(self)
  end

end
