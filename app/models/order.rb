class Order < ApplicationRecord
  include AASM

  has_many :line_items
  belongs_to :user, optional: true

  has_many :addresses, as: :resource, dependent: :destroy
  enum status: { cart: 0, address: 1, delivery: 2, payment: 3, confirmation: 4, completed: 5 }

  aasm :status, enum: true do
    state :cart, initial: true
    state :address
    state :delivery
    state :payment
    state :confirmation
    state :completed

    event :address do
      transitions from: :cart, to: :address
    end

    event :delivery do
      transitions from: :address, to: :delivery
    end

    event :payment do
      transitions from: :delivery, to: :payment
    end

    event :confirmation do
      transitions from: :payment, to: :confirmation
    end

    event :completed do
      transitions from: :confirmation, to: :completed
    end
  end
end
