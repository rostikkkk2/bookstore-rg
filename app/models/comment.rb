class Comment < ApplicationRecord
  enum status: { unprocessed: 0, approved: 1, rejected: 2 }

  belongs_to :user
  belongs_to :book
end
