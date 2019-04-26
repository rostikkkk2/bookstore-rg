class AddressSettingsService < AddressBaseService
  def call
    @form = params[:billing_form] ? @billing : @shipping
    return false unless @form.valid?

    create_or_update_address(@form)
  end

  def create_or_update_address(form)
    current_address = current_user.addresses.find_by(address_type: params[:address_type])
    current_address ? form.update_address(current_address) : form.create_address
  end

  def presenter
    AddressPresenter.new(
      params: params,
      current_user: current_user,
      billing_form: billing,
      shipping_form: shipping
    )
  end
end
