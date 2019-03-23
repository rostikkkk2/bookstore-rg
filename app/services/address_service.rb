class AddressService
  attr_reader :params, :current_user, :billing, :shipping

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
    @billing = AddressForm.new(params[:billing_form]&.permit!)
    @shipping = AddressForm.new(params[:shipping_form]&.permit!)
  end

  def settings_call
    @form = params[:billing_form] ? @billing : @shipping
    return false unless @form.valid?

    create_or_update_address(@form)
  end

  def checkout_call
    create_or_update_checkout_addresses and return true if @billing.valid? && @shipping.valid?

    @shipping.valid? && @billing.valid?
  end

  def create_or_update_checkout_addresses
    billing_address = check_current_order_address(:billing_form)
    shipping_address = check_current_order_address(:shipping_form)

    billing_address ? @billing.update_address(billing_address) : @billing.create_address
    shipping_address ? @shipping.update_address(shipping_address) : @shipping.create_address
  end

  def create_or_update_address(form)
    current_address = check_current_address
    current_address ? form.update_address(current_address) : form.create_address
  end

  private

  def check_current_address
    Address.find_by(resource_id: current_user.id, resource_type: 'User', address_type: params[:address_type])
  end

  def check_current_order_address(form)
    Address.find_by(resource_id: params[form][:order_id], resource_type: 'Order', address_type: params[form][:address_type])
  end
end
