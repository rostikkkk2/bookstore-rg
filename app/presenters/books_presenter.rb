class BooksPresenter < Rectify::Presenter
  COUNT_NEW_BOOKS = 3
  COUNT_TOP_BOOKS = 4

  def btn_all_books
    link_to 'All', books_path, class: "filter-link hover_category_color #{'def-color-chosen-category' if !params[:category_id]}"
  end

  def all_books
    Book.all
  end

  def all_categories
    Category.all
  end

  def order_current_user
    Order.find_by(user_id: current_user.id)
  end

  def all_line_items_user
    LineItem.where(order_id: order_current_user)
  end

  def count_books_in_cart
    if user_signed_in?
      item_quantities = all_line_items_user.map {|item| item.quantity}
      item_quantities.sum
    else
      0
    end
  end

  def new_books_slider
    all_books.last(COUNT_NEW_BOOKS)
  end

  def top_books
    all_books.first(COUNT_TOP_BOOKS)
  end

  def btn_categories(category)
    link_to category.name, category_books_path(category), class: "filter-link hover_category_color #{'def-color-chosen-category' if params[:category_id].to_i == category.id}"
  end

  def count_books_category(category)
    all_books.where(category_id: category.id).count
  end

  def count_all_books
    all_books.count
  end

  def show_current_category
    params[:id] ? all_categories.find_by(id: params[:id]).name : 'All books'
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
