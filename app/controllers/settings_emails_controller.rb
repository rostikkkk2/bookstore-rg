class SettingsEmailsController < ApplicationController
  def update
    email_service = EmailService.new(params, current_user)
    if email_service.save
      flash[:success] = I18n.t('controllers.updated_email')
    else
      flash[:error] = email_service.email_form.errors.full_messages.to_sentence
    end
    redirect_to new_setting_path
  end
end
