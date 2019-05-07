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
    # top_books = {}
    # Order.joins(:line_items, :books).where("book_id == id")
    # LineItem.joins(:books).where("books.id == line_items.book_id")
    top_books = Book.joins(:line_items)
    # Order.all.each do |order|
    #   order.line_items.each { |item| top_books[item.book] = item.book.id }
    # end
    # p top_books.group_by.map { |key, _| key }
    top_books.group_by.map { |key, _| key }.first(COUNT_TOP_BOOKS)
  end

  def show_sort_type
    params[:sort_by] ? t("sort_books.#{params[:sort_by]}") : t('sort_books.asc_title')
  end

  def show_img_or_default(size, book)
    image_tag book.photo_url ? book.photo_url(size) : 'default.png', class: 'img-shadow general-thumbnail-img'
  end
end
