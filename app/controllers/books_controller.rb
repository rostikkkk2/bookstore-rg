class BooksController < ApplicationController
  load_and_authorize_resource

  include Pagy::Backend
  COUNT_PAGE_BOOKS = 12

  def show
    @current_book = Book.find_by(id: params[:id].to_i)
    @comment_presenter = CommentPresenter.new(current_book: @current_book)
    @current_book_presenter = CurrentBookPresenter.new(current_book: @current_book)
  end

  def index
    @sorted_books = SortingService.new(Book.all, params).call
    @books_presenter = BooksPresenter.new.attach_controller(self)
    @pagy, @books_category = pagy(@sorted_books, items: COUNT_PAGE_BOOKS)
  end
end
