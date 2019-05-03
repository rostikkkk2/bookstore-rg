class AddressBaseService
  attr_reader :params, :current_user, :current_order, :billing, :shipping, :form

  def initialize(params, current_user, current_order)
    @params = params
    @current_user = current_user
    @current_order = current_order
    @billing = AddressForm.new(params[:billing_form])
    @shipping = AddressForm.new(params[:shipping_form])
  end

  def create_address
    new_address = Address.new(form.attributes.without(:user_id, :order_id))
    new_address.resource = Order.find_by(id: form.order_id) || User.find_by(id: form.user_id)
    new_address.save
  end

  def update_address(current_address)
    current_address.update(form.attributes.without(:user_id, :order_id))
  end
end
