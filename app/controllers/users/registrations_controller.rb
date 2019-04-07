class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    if email_taken_in_quick_signup?
      redirect_to(user_session_path, notice: 'email exists')
    else
      secret_password_token if params[:checkout_signup]
      super
      return unless params[:checkout_signup]

      resource.send_reset_password_instructions if params[:checkout_signup]
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def after_sign_up_path_for(resource)
    params[:checkout_signup] ? carts_path : super(resource)
  end

  private

  def secret_password_token
    params[:user][:password] = params[:user][:password_confirmation] = Devise.friendly_token[0, 10]
  end

  def email_taken_in_quick_signup?
    params[:checkout_signup] && (User.where(email: params[:user][:email]).first&.email == params[:user][:email])
  end
end
