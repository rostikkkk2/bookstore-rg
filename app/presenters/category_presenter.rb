class CategoryPresenter < Rectify::Presenter
  attribute :categories, Category
  attribute :books, Book

  def btn_all_books
    link_to 'All', category_path('all_books'), class: "filter-link hover_category_color #{'def-color-chosen-category' if params[:id] == 'all_books'}"
  end

  def btn_categories(category)
    link_to category.name, category_path(category), class: "filter-link hover_category_color #{'def-color-chosen-category' if params[:id].to_i == category.id}"
  end

  def count_books_category(category)
    books.where(category_id: category.id).count
  end

  def show_current_category
    params[:id] == 'all_books' ? 'All books' : categories.where(id: params[:id]).first.name
  end

  def btn_all_books_phone_expansion
    link_to 'All books', category_path('all_books')
  end

  def btn_categories_phone_expansion(category)
    link_to category.name, category_path(category)
  end

  def show_sort_type
    params[:sort_by] ? t("sort_books.#{params[:sort_by]}") : t('sort_books.asc_title')
  end

  def types_sort_filter(key)
    link_to t("sort_books.#{key}"), category_path(sort_by: key)
  end

  def show_img_or_default(size, book)
    if book.photo_url.present?
      image_tag book.photo_url(size), alt: "design-book", class: 'img-shadow general-thumbnail-img'
    else
      image_tag('w550_default.jpg', alt: "design-book", class: 'img-shadow general-thumbnail-img')
    end
  end
end
