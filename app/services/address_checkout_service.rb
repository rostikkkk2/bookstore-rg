class AddressCheckoutService < AddressBaseService
  def call
    return create_billing_with_hidden_shipping if billing.valid? && params[:hidden_shipping_form]

    create_or_update_checkout_addresses if billing.valid? & shipping.valid?
  end

  def create_or_update_checkout_addresses
    create_or_update_address(billing, current_order.addresses.billing)
    create_or_update_address(shipping, current_order.addresses.shipping)
  end

  def create_billing_with_hidden_shipping
    create_or_update_address(billing, current_order.addresses.billing)
    billing.address_type = Address.address_types.keys.last
    create_or_update_address(billing, current_order.addresses.shipping)
  end

  def create_or_update_address(form_object, data_address)
    address = data_address.first
    @form = form_object
    address ? update_address(address) : create_address
  end

  def presenter
    AddressPresenter.new(params: params, current_order: current_order, billing_form: billing, shipping_form: shipping)
  end
end
