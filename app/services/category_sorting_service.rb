class CategorySortingService

  SORT_BOOKS = {
    asc_title: ->(instance) { instance.order_by('name ASC') },
    desc_title: ->(instance) { instance.order_by('name DESC') },
    asc_price: ->(instance) { instance.order_by('price ASC') },
    desc_price: ->(instance) { instance.order_by('price DESC') },
    newest_first: ->(instance) { instance.order_by('id DESC') },
    # popular_books: ->(instance) { instance.popular_sort },
  }.freeze

  def self.call(books)
    @books = books
    @books_category = select_books_by_category
    sort_books
  end

  def sort_books
    sort_param = if params[:sort_by] && SORT_BOOKS.include?(params[:sort_by].to_sym)
      params[:sort_by].to_sym
    else
      params[:sort_by] = :asc_title
    end
    @books_category = SORT_BOOKS[sort_param].call(self)
  end

  def order_by(by)
    @books_category = @books_category.order(by)
  end

  def select_books_by_category
    books_chosen_category = @books.where(category_id: params[:id].to_i)
    return (params[:id] == 'all_books') ? @books : books_chosen_category
  end

end
