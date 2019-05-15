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
end
