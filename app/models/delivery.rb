class Delivery < ApplicationRecord
  has_many :orders, dependent: :destroy
end
