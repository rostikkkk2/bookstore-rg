class AddressService
  attr_reader :params, :current_user, :current_order, :billing, :shipping
  SHIPPING_TYPE_ADDRESS = 'shipping'.freeze
  TYPE_USER_IN_ADDRESS = 'User'.freeze

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

    create_or_update_settings_address(@form)
  end

  def checkout_call
    return create_billing_with_hidden_shipping if @billing.valid? && params[:hidden_shipping_form]

    create_or_update_checkout_addresses & true if @billing.valid? & @shipping.valid?
  end

  def create_or_update_checkout_addresses
    create_or_update_checkout_address(@billing, current_order.addresses.billing)
    create_or_update_checkout_address(@shipping, current_order.addresses.shipping)
  end

  def create_billing_with_hidden_shipping
    create_or_update_checkout_address(@billing, current_order.addresses.billing)
    @billing.address_type = SHIPPING_TYPE_ADDRESS
    create_or_update_checkout_address(@billing, current_order.addresses.shipping)
  end

  def create_or_update_checkout_address(form_object, data_address)
    address = data_address.first
    address ? form_object.update_address(address) : form_object.create_address
  end

  def create_or_update_settings_address(form)
    current_address = check_current_address
    current_address ? form.update_address(current_address) : form.create_address
  end

  private

  def check_current_address
    Address.find_by(resource_id: current_user.id, resource_type: TYPE_USER_IN_ADDRESS, address_type: params[:address_type])
  end
end
