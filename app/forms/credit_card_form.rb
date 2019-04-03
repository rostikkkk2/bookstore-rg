class CreditCardForm
  include ActiveModel::Model
  include Virtus

  attribute :number, String
  attribute :name, String
  attribute :date, String
  attribute :cvv, Integer
  attribute :order_id, Integer

  validates :number, :name, :date, :cvv, :order_id, presence: true
  validates :number, length: { is: 16 }, numericality: { only_integer: true, message: 'Must be only numbers' }
  validates :name, length: { maximum: 15 }
  validates :date, format: { with: %r{\A^(0[1-9]|1[0-2])\/?([0-9]{2})$\z}, message: 'should be in MM/YY format and contain only numbers' }
  validates :cvv, length: { minimum: 3, maximum: 4 }, numericality: { only_integer: true, message: 'Must be only numbers' }

  def create_credit_card
    CreditCard.new(number: number, name: name, date: date, cvv: cvv, order_id: order_id).save!
  end

  def update_credit_card
    CreditCard.find_by(order_id: order_id).update(number: number, name: name, date: date, cvv: cvv)
  end
end
