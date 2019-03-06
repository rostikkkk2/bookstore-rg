class AddressesController < ApplicationController
  def index
    @address_presenter = AddressPresenter.new(current_user: current_user).attach_controller(self)
    @address_form = AddressForm.new
  end

  def create
    @address_form = AddressForm.new(addresses_params)
    address_service = AddressService.new(params, current_user, @address_form).call
    return redirect_to addresses_path if address_service

    render_errors_address(@address_form)
  end

  def render_errors_address(form)
    @address_errors = form.errors.messages
    @address_presenter = AddressPresenter.new(errors: @address_errors, params: params, current_user: current_user).attach_controller(self)
    render :index
  end

  private

  def addresses_params
    type_form = params[:address_type]
    params[type_form].permit(:address_type, :first_name, :last_name, :address, :city, :zip, :country, :phone, :user_id)
  end
end
