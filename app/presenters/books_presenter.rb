class BooksPresenter < Rectify::Presenter
  attribute :params

  COUNT_NEW_BOOKS = 3
  COUNT_TOP_BOOKS = 4

  def all_books
    Book.all
  end

  def all_categories
    Category.all
  end

  def new_books_slider
    all_books.last(COUNT_NEW_BOOKS)
  end

  def top_books
    top_books = Book.joins(:orders).group(:id).count.sort_by { |_, value| -value }.first(COUNT_TOP_BOOKS)
    top_books.map { |book| Book.find_by(id: book.first) }
  end

  def show_sort_type
    params[:sort_by] ? t("sort_books.#{params[:sort_by]}") : t('sort_books.asc_title')
  end

  def show_img_or_default(size, book)
    image_tag book.photo_url ? book.photo_url(size) : 'default.png', class: 'img-shadow general-thumbnail-img'
  end
end
