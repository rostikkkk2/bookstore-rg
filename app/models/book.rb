class Book < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :category
  has_many :book_authors
  has_many :authors, through: :book_authors, dependent: :destroy
  has_many :comments, dependent: :destroy

end
