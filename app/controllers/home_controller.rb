class HomeController < ApplicationController
  def index
    books = Book.all
    @top_books = books.first(4)
    @new_books = books.last(3)
  end

end
