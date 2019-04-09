class PageController < ApplicationController
  def index
    @books_presenter = BooksPresenter.new.attach_controller(self)

  end
end
