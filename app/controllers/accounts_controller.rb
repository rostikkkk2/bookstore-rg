class AccountsController < ApplicationController
  DELETED_ACCOUNT = 'Your account successfuly deleted'.freeze
  ERROR_DELETED_ACCOUNT = 'Your account was not deleted'.freeze
  WRONG_PASSWORD = 'Wrong password'.freeze
  SUCCESS_CHANGE_PASSWORD = 'Successfuly changed password'.freeze

  def destroy
    account = User.find_by(id: params[:id].to_i)
    account&.destroy ? flash[:success] = DELETED_ACCOUNT : flash[:error] = ERROR_DELETED_ACCOUNT
    redirect_to root_path
  end

  def update
    change_password = ChangePasswordService.new(current_user, params).call
    change_password ? flash[:success] = SUCCESS_CHANGE_PASSWORD : flash[:error] = WRONG_PASSWORD
    sign_in(current_user, bypass: true)
    redirect_to new_setting_path
  end
end
