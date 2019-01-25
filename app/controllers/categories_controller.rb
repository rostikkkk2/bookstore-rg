class CategoriesController < ApplicationController
  include Pagy::Backend

  def show
    @books = Book.all
    @categories = Category.all
    result = CategorySortingService.call(@books)
    @pagy, @books_category = pagy(result, items: 12)
  end

end
