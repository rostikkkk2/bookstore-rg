class CurrentBookPresenter < Rectify::Presenter
  attribute :current_book, Book
  VISIBLE_LENGTH_DESCRIPTION_BOOK = 100

  def all_categories
    Category.all
  end

  def desctiption_length_valid?
    current_book.description.length > VISIBLE_LENGTH_DESCRIPTION_BOOK
  end

  def show_all_description_text
    current_book.description
  end

  def show_current_img_or_default(size)
    image_tag current_book.photo_url ? current_book.photo_url(size) : 'default.png', class: 'img-responsive'
  end

  def show_description
    current_book.description[0..VISIBLE_LENGTH_DESCRIPTION_BOOK]
  end

  def show_params_current_book
    "H:#{current_book.heigth}\" x W: #{current_book.width}\" x D: #{current_book.depth}"
  end
end
