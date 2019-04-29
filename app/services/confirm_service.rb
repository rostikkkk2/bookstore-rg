class ConfirmService
  attr_reader :current_order

  BEGIN_SECRET_NUMBER = '#R'.freeze
  LENGTH_SECRET_NUMBER = 13
  RANGE_SECRET_NUMBER = (0..9).freeze

  def initialize(params, current_user, current_order)
    @params = params
    @current_user = current_user
    @current_order = current_order
  end

  def call
    use_current_coupon
    create_secret_key
  end

  def use_current_coupon
    current_order.coupon&.update(used: true)
  end

  def create_secret_key
    current_order.update(number: generate_order_secret_number)
  end

  def generate_order_secret_number
    Array.new(LENGTH_SECRET_NUMBER) { [rand(RANGE_SECRET_NUMBER)] }.unshift(BEGIN_SECRET_NUMBER).join
  end
end
