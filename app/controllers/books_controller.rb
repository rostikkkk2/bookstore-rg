class BooksController < ApplicationController

  def show
    @books = Book.all
    @current_book = @books.find_by(id: params[:id].to_i)
    @presenter = BookPresenter.new(:current_book => @current_book, :books => @books).attach_controller(self)
  end

end
