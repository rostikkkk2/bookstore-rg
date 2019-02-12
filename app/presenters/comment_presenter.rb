class CommentPresenter < Rectify::Presenter
  attribute :current_book, Book

  COUNT_STARS = 5
  MIN_STARS = 1

  def all_comments
    Comment.where(book_id: current_book.id)
  end

  def count_comments
    "#{t('book_page.comment.reviews')} (#{all_comments.where(book_id: @current_book.id).count})"
  end

  def first_letter_email_user(comment)
    User.find_by(id: comment.user_id).email.first
  end

  def date(comment)
    comment.created_at.to_date
  end

  def is_verified?(comment)
    t('book_page.comment.verified_reviewer') if comment.is_verified
  end

  def name_email_user(comment)
    User.find_by(id: comment.user_id).email
  end

  def check_star(star, comment)
    comment.rating && star < comment.rating ? 'rate-star' : 'star-not-checked'
  end
end
