class AddressesController < ApplicationController
  def show
    @address_presenter = AddressPresenter.new(current_user: current_user).attach_controller(self)
    @address_form = AddressForm.new
  end

  def create
    @address_form = AddressForm.new(addresses_params)
    if @address_form.save
      redirect_to address_path(current_user)
    else
      @address_errors = @address_form.errors.messages
      @address_presenter = AddressPresenter.new(errors: @address_errors, params: params, current_user: current_user).attach_controller(self)
      render :show
    end
  end

  private

  def addresses_params
    type_form = params[:billing] ? :billing : :shipping
    params[type_form].permit(:address_type, :first_name, :last_name, :address, :city, :zip, :country, :phone, :user_id)
  end
end
