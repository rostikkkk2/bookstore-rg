class Book < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :category
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :book_images, dependent: :destroy
  has_many :orders, through: :line_items
end
