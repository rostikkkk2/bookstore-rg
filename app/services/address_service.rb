class AddressService
  attr_reader :params, :current_user, :address_form

  def initialize(params, current_user, address_form)
    @params = params
    @current_user = current_user
    @address_form = address_form
  end

  def call
    return false unless address_form.valid?

    create_or_update_address
  end

  def create_or_update_address
    current_address = check_current_address
    current_address ? address_form.update_address(current_address) : address_form.create_address
  end

  def check_current_address
    Address.find_by(resource_id: current_user.id, resource_type: 'User', address_type: params[:address_type])
  end
end
