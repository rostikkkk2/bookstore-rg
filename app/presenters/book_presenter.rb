class BookPresenter < Rectify::Presenter
  attribute :books, Book
  attribute :current_book, Book

  def desctiption_length_valid?(length_text)
    current_book.description.length > length_text
  end

  def show_all_description_text
    current_book.description[0..@current_book.description.length]
  end

  def show_img_or_default(size)
    if @current_book.photo_url.present?
      image_tag @current_book.photo_url(size), alt: "design-book", class: 'img-responsive'
    else
      image_tag('w550_default.jpg', alt: "design-book", class: 'img-responsive')
    end
  end

end
