class CategorySortingService < ApplicationController

  attr_reader :params, :books

  SORT_BOOKS = {
    asc_title: ->(instance) { instance.order_by('name ASC') },
    desc_title: ->(instance) { instance.order_by('name DESC') },
    asc_price: ->(instance) { instance.order_by('price ASC') },
    desc_price: ->(instance) { instance.order_by('price DESC') },
    newest_first: ->(instance) { instance.order_by('id DESC') },
    # popular_books: ->(instance) { instance.popular_sort },
  }.freeze


  def initialize(books, params)
    @books = books
    @params = params
  end

  def call
    @books_category = select_books_by_category
    sort_books
  end

  def sort_books
    params[:sort_by] = :asc_title unless params[:sort_by]
    return not_fount unless SORT_BOOKS.include?(params[:sort_by].to_sym)
    @books_category = SORT_BOOKS[params[:sort_by].to_sym].call(self)
  end

  def order_by(by)
    @books_category = @books_category.order(by)
  end

  def select_books_by_category
    books_chosen_category = books.where(category_id: params[:id].to_i)
    return (params[:id] == 'all_books') ? books : books_chosen_category
  end

end
