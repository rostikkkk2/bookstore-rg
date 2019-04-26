class BooksPresenter < Rectify::Presenter
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
    top_books = {}
    Order.all.each do |order|
      order.line_items.each { |item| top_books[item.book] = item.book.id }
    end
    top_books.group_by.map { |key, _| key }.first(COUNT_TOP_BOOKS)
  end

  def count_books_category(category)
    all_books.where(category_id: category.id).count
  end

  def count_all_books
    all_books.count
  end

  def show_current_category
    params[:id] ? all_categories.find_by(id: params[:id]).name : I18n.t('book_page.all_categories')
  end

  def show_sort_type
    params[:sort_by] ? t("sort_books.#{params[:sort_by]}") : t('sort_books.asc_title')
  end

  def show_img_or_default(size, book)
    image_tag book.photo_url ? book.photo_url(size) : 'default.png', class: 'img-shadow general-thumbnail-img'
  end

  def sort_books(key)
    link_to t("sort_books.#{key}"), params[:category_id] ? category_books_path(sort_by: key) : books_path(sort_by: key)
  end
end
