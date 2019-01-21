class BooksController < ApplicationController

  def show
    @books = Book.all
    @current_book = @books.find_by(id: params[:id].to_i)
  end

end
