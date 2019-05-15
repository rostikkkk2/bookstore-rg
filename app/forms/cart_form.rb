class CartForm
  include ActiveModel::Model
  include Virtus

  attribute :current_user, Integer
  attribute :current_book, Integer
  attribute :count_books, Integer

  validates :count_books, presence: true, length: { maximum: 10 }
  validates :current_book, presence: true
end
