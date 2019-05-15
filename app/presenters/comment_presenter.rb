class CommentPresenter < Rectify::Presenter
  attribute :current_book, Book

  COUNT_STARS = 5
  MIN_STARS = 1

  def all_comments
    current_book.comments
  end

  def is_verified?(comment)
    t('book_page.comment.verified_reviewer') if comment.is_verified
  end

  def check_star(star, comment)
    comment.rating && star < comment.rating ? 'rate-star' : 'star-not-checked'
  end
end
