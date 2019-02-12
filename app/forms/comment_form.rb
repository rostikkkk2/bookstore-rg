class CommentForm
  include ActiveModel::Model
  include Virtus

  attribute :title, String
  attribute :text_comment, String
  attribute :current_user, Integer
  attribute :current_book, Integer
  attribute :rating, Integer

  validates :title, presence: true, length: { maximum: 100 }
  validates :text_comment, presence: true, length: { maximum: 500 }

  def save
    create_comment if valid?
  end

  private

  def create_comment
    new_comment = Comment.new(
      title: title,
      text_comment: text_comment,
      rating: rating,
      user_id: current_user,
      book_id: current_book
    )
    new_comment.save!
  end
end
