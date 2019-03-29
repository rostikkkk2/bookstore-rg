class AddressesController < ApplicationController
  def create
    address_service = AddressService.new(params, current_user, current_order)
    return redirect_to new_setting_path if address_service.settings_call

    render_with_presenter(address_service)
  end

  def render_with_presenter(address_service)
    @presenter = AddressPresenter.new(params: params, current_user: current_user,
      billing_form: address_service.billing, shipping_form: address_service.shipping).attach_controller(self)
    render template: 'settings/new'
  end
end
