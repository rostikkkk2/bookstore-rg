class CategoriesController < ApplicationController
  attr_accessor :books_category, :books

  def index
    @books = Book.all
    @categories = Category.all
    @books_category = select_books_by_category
    sort_books
  end

  def sort_books
    # do sort with session???
    @books_category = @books_category.order(:price) if params[:sort_price]
    @books_category = @books_category.order(price: :desc) if params[:sort_price_desk]
  end

  def select_books_by_category
    books_chosen_category = @books.where(category_id: params[:category_id].to_i)
    return (params[:category_id] == 'all_categories') ? Book.all : books_chosen_category
  end
end
