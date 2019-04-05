class ConfirmService
  attr_reader :current_order

  BEGIN_SECRET_NUMBER = '#R'.freeze
  LENGTH_SECRET_NUMBER = 13
  RANGE_SECRET_NUMBER = (0..9).freeze

  def initialize(current_order)
    @current_order = current_order
  end

  def create_secret_key
    current_order.update(number: generate_order_secret_number)
  end

  def generate_order_secret_number
    Array.new(LENGTH_SECRET_NUMBER) { [rand(RANGE_SECRET_NUMBER)] }.unshift(BEGIN_SECRET_NUMBER).join
  end
end
