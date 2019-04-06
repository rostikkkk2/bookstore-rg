class SettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @presenter = AddressPresenter.new(current_user: current_user).attach_controller(self)
  end
end
