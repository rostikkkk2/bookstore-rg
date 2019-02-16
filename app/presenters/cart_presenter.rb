class CartPresenter < Rectify::Presenter

  def subtotal_prise_book(book)
    "€#{book.price * LineItem.find_by(book_id: book.id).quantity}"
  end

end
