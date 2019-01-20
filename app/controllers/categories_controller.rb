class CategoriesController < ApplicationController
  def index
    @books = Book.all
    @categories = Category.all
    books_chosen_category = @books.where(category_id: params[:category_id].to_i)
    @books_category = params[:category_id] == 'all_categories' ? Book.all : books_chosen_category
  end
end
