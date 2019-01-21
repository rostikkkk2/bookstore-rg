class CategoriesController < ApplicationController

  def show
    @books = Book.all
    @categories = Category.all
    @books_category = select_books_by_category
    sort_books
  end

  def sort_books
    @books_category = @books_category.order(:price) if params[:sort_price]
    @books_category = @books_category.order(price: :desc) if params[:sort_price_desk]
  end

  def select_books_by_category
    books_chosen_category = @books.where(category_id: params[:id].to_i)
    return (params[:id] == 'all_books') ? @books : books_chosen_category
  end
end
