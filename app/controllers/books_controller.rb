class BooksController < ApplicationController
  include Pagy::Backend
  COUNT_PAGE_BOOKS = 12

  def show
    @current_book = Book.all.find_by(id: params[:id].to_i)
    @comment_presenter = CommentPresenter.new(current_book: @current_book).attach_controller(self)
    @presenter = CurrentBookPresenter.new(current_book: @current_book).attach_controller(self)
  end

  def index
    @sorted_books = SortingService.new(Book.all, params).call
    @pagy, @books_category = pagy(@sorted_books, items: COUNT_PAGE_BOOKS)
  end

end
