class SettingsEmailsController < ApplicationController
  def update
    email_form = EmailForm.new(params_email)
    flash[:error] = email_form.errors.full_messages.to_sentence unless email_form.save
    redirect_to addresses_path
  end

  def params_email
    params.permit(:email, :user_id)
  end
end
