class AccountsController < ApplicationController

  DELETED_ACCOUNT = 'Your account successfuly deleted'.freeze
  ERROR_DELETED_ACCOUNT = 'Your account was not deleted'.freeze
  WRONG_PASSWORD = 'Wrong password'.freeze
  SUCCESS_CHANGE_PASSWORD = 'Successfuly changed password'.freeze

  def destroy
    account_delete = User.find_by(id: current_user.id).delete
    account_delete ? flash[:success] = DELETED_ACCOUNT : flash[:error] = ERROR_DELETED_ACCOUNT
    redirect_to root_path
  end

  def update
    change_password = ChangePasswordService.new(current_user, params).call
    change_password ? flash[:success] = SUCCESS_CHANGE_PASSWORD : flash[:error] = WRONG_PASSWORD
    redirect_to new_setting_path
  end
end
