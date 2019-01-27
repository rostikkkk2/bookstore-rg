class CategoriesController < ApplicationController
  include Pagy::Backend

  def show
    @books = Book.all
    @categories = Category.all
    result = CategorySortingService.new(@books, params).call
    @pagy, @books_category = pagy(result, items: 12)
    @presenter = CategoryPresenter.new(:categories => @categories, :books => @books).attach_controller(self)
  end

end
