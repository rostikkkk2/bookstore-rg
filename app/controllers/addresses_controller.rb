class AddressesController < ApplicationController
  authorize_resource

  def create
    address_service = AddressSettingsService.new(params, current_user, current_order)
    return redirect_to new_setting_path if address_service.call

    @presenter = address_service.presenter
    render template: 'settings/new'
  end
end
