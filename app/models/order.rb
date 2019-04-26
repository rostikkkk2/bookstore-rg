class Order < ApplicationRecord
  include AASM

  has_many :line_items, dependent: :destroy
  belongs_to :delivery, optional: true
  belongs_to :user, optional: true
  has_one :coupon, dependent: :nullify

  scope :in_progress, -> { Order.where(status: 'complete') }
  scope :in_delivery, -> { Order.where(status: 'in_delivery') }
  scope :delivered, -> { Order.where(status: 'delivered') }
  scope :canceled, -> { Order.where(status: 'canceled') }

  has_many :addresses, as: :resource, dependent: :destroy
  enum status: { cart: 0, address: 1, delivery: 2, payment: 3, confirm: 4, complete: 5,
                 in_delivery: 6, delivered: 7, canceled: 8 }
  has_one :credit_card, dependent: :destroy

  aasm :status, enum: true do
    state :cart, initial: true
    state :address
    state :delivery
    state :payment
    state :confirm
    state :complete
    state :in_delivery
    state :delivered
    state :canceled

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

    event :in_delivery do
      transitions from: :complete, to: :in_delivery
    end

    event :delivered do
      transitions from: :in_delivery, to: :delivered
    end

    event :canceled do
      transitions from: %i[complete in_delivery delivered], to: :canceled
    end
  end
end
