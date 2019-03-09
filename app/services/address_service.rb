class AddressService
  attr_reader :params, :current_user, :billing, :shipping

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
    @billing = AddressForm.new(params[:billing_form]&.permit!)
    @shipping = AddressForm.new(params[:shipping_form]&.permit!)
  end

  def call
    @form = params[:billing_form] ? @billing : @shipping
    return false unless @form.valid?

    create_or_update_address(@form)
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
