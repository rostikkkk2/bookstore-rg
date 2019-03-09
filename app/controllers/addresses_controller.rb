class AddressesController < ApplicationController
  def create
    @address_service = AddressService.new(params, current_user)
    return redirect_to new_setting_path if @address_service.call

    @shipping = @address_service.shipping
    @billing = @address_service.billing
    render_with_presenter
  end

  def render_with_presenter
    @address_presenter = AddressPresenter.new(params: params, current_user: current_user).attach_controller(self)
    render template: 'settings/new'
  end
end
