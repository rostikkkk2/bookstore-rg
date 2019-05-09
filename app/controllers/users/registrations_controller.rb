class Users::RegistrationsController < Devise::RegistrationsController
  before_action only: :create

  def create
    return checkout_registrate_user if email_taken_in_quick_signup?

    super
  end

  def checkout_registrate_user
    secret_password_token
    build_resource(sign_up_params)
    resource.skip_confirmation!
    resource.save ? authenticate_user : redirect_to(user_session_path, notice: 'email exists')
  end

  def authenticate_user
    sign_up(resource_name, resource)
    resource.send_reset_password_instructions
    redirect_to carts_path
  end

  private

  def secret_password_token
    params[:user][:password] = params[:user][:password_confirmation] = Devise.friendly_token[0, 10]
  end

  def email_taken_in_quick_signup?
    params[:checkout_signup] && !User.find_by(email: params[:user][:email])
  end
end
