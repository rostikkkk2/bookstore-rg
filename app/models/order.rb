class Order < ApplicationRecord
  has_many :line_items
  belongs_to :user
  enum status: {cart: 0, address: 1, delivery: 2, payment: 3, confirmation: 4}
end
