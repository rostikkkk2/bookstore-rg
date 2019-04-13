class SettingsEmailsController < ApplicationController
  SUCCESS_UPDATE_EMAIL_MESSAGE = 'Your email successfuly update'.freeze

  def update
    email_form = EmailForm.new(params_email)
    if email_form.save
      flash[:success] = SUCCESS_UPDATE_EMAIL_MESSAGE
    else
      flash[:error] = email_form.errors.full_messages.to_sentence
    end
    redirect_to new_setting_path
  end

  def params_email
    params.permit(:email, :user_id)
  end
end
