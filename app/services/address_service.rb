class AddressService
  attr_reader :params, :current_user, :current_order, :billing, :shipping

  def initialize(params, current_user, current_order)
    @params = params
    @current_user = current_user
    @current_order = current_order
    @billing = AddressForm.new(params[:billing_form]&.permit!)
    @shipping = AddressForm.new(params[:shipping_form]&.permit!)
  end

  def settings_call
    @form = params[:billing_form] ? @billing : @shipping
    return false unless @form.valid?

    create_or_update_address(@form)
  end

  def checkout_call
    return create_billing_with_hidden_shipping if @billing.valid? && params[:hidden_shipping_form]

    create_or_update_checkout_addresses & true if @billing.valid? & @shipping.valid?
  end

  def create_or_update_checkout_addresses
    billing_address = current_order.addresses.billing.first
    shipping_address = current_order.addresses.shipping.first

    billing_address ? @billing.update_address(billing_address) : @billing.create_address
    shipping_address ? @shipping.update_address(shipping_address) : @shipping.create_address
  end

  def create_billing_with_hidden_shipping
    billing_address = current_order.addresses.billing.first
    billing_address ? @billing.update_address(billing_address) : @billing.create_address
    @billing.address_type = 'shipping'

    shipping_address = current_order.addresses.shipping.first
    shipping_address ? @billing.update_address(shipping_address) : @billing.create_address
  end

  def create_or_update_address(form)
    current_address = check_current_address
    current_address ? form.update_address(current_address) : form.create_address
  end

  private

  def check_current_address
    Address.find_by(resource_id: current_user.id, resource_type: 'User', address_type: params[:address_type])
  end
end
