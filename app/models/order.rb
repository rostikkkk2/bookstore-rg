class Order < ApplicationRecord
  has_many :line_items
  enum status: { cart: 0, address: 1, delivery: 2, payment: 3, confirmation: 4 }
  belongs_to :user, optional: true

  has_many :addresses, as: :resource
end
