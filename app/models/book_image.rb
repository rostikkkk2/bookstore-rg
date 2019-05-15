class BookImage < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :book, optional: true
end
