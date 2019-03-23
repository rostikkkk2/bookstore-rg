class SettingsController < ApplicationController

  def new
    return redirect_to root_path unless current_user

    @presenter = AddressPresenter.new(current_user: current_user).attach_controller(self)
    @shipping = AddressForm.new
    @billing = AddressForm.new
  end
end
