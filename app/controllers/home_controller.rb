class HomeController < ApplicationController
  def index
    @top_books = Book.all.first(4)
  end
end
