class Order < ApplicationRecord
  include AASM

  has_many :line_items
  belongs_to :delivery, optional: true
  belongs_to :user, optional: true

  has_many :addresses, as: :resource, dependent: :destroy
  enum status: { cart: 0, address: 1, delivery: 2, payment: 3, confirm: 4, complete: 5 }
  has_one :credit_card

  aasm :status, enum: true do
    state :cart, initial: true
    state :address
    state :delivery
    state :payment
    state :confirm
    state :complete

    event :address do
      transitions from: :cart, to: :address
    end

    event :delivery do
      transitions from: :address, to: :delivery
    end

    event :payment do
      transitions from: :delivery, to: :payment
    end

    event :confirm do
      transitions from: :payment, to: :confirm
    end

    event :complete do
      transitions from: :confirm, to: :complete
    end
  end
end
