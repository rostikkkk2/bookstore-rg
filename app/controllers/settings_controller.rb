class SettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @presenter = AddressPresenter.new(current_user: current_user)
  end
end
