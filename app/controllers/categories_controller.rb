class CategoriesController < ApplicationController
  include Pagy::Backend

  SORT_BOOKS = {
    asc_title: 'Title: A - Z',
    desc_title: 'Title: Z - A',
    asc_price: 'Price: Low to hight',
    desc_price: 'Price: Hight to low',
    newest_first: 'Newest first',
    popular_books: 'Popular first'
  }

  def show
    @books = Book.all
    @categories = Category.all
    @pagy, @books_category = pagy(select_books_by_category, items: 12)
    sort_books
  end

  def sort_books
    order_by('name DESC', SORT_BOOKS[:desc_title])
    order_by('price ASC', SORT_BOOKS[:asc_price])
    order_by('price DESC', SORT_BOOKS[:desc_price])
    order_by('id DESC', SORT_BOOKS[:newest_first])
    @books_category = @books_category.order(:name)
  end

  def order_by(by, kind_books)
    @books_category = @books_category.order(by) if params[:sort_by] == kind_books
  end

  def select_books_by_category
    books_chosen_category = @books.where(category_id: params[:id].to_i)
    return (params[:id] == 'all_books') ? @books : books_chosen_category
  end
end
