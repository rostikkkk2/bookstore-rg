class AccountsController < ApplicationController
  def destroy
    account = User.find_by(id: params[:id].to_i)
    if account&.destroy
      flash[:success] = I18n.t('controllers.deleted_account')
    else
      flash[:error] = I18n.t('controllers.error_deleted_account')
    end
    redirect_to root_path
  end

  def update
    change_password = ChangePasswordService.new(current_user, params).call
    if change_password
      flash[:success] = I18n.t('controllers.changed_password')
    else
      flash[:error] = I18n.t('controllers.wrong_password')
    end
    sign_in(current_user, bypass: true)
    redirect_to new_setting_path
  end
end
