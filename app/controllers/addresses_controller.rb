class AddressesController < ApplicationController
  def create
    @address_service = AddressService.new(params, current_user, current_order)
    return redirect_to new_setting_path if @address_service.settings_call

    @shipping = @address_service.shipping
    @billing = @address_service.billing
    return render_with_presenter
  end

  def render_with_presenter
    @presenter = AddressPresenter.new(params: params, current_user: current_user, current_order: current_order).attach_controller(self)
    render template: 'settings/new'
  end
end
