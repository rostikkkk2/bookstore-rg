class UserRegistrationService < Devise::RegistrationsController
  # attr_reader :params
  #
  # def initialize(params)
  #   @params = params
  # end
  #
  # def call
  #   checkout_registrate_user
  # end
  #
  # def checkout_registrate_user
  #   secret_password_token
  #   build_resource(sign_up_params)
  #   resource.save ? authenticate_user : redirect_to(user_session_path, notice: 'email exists')
  # end
  #
  # def authenticate_user
  #   sign_up(resource_name, resource)
  #   resource.send_reset_password_instructions
  #   redirect_to carts_path
  # end
  #
  # private
  #
  # def secret_password_token
  #   params[:user][:password] = params[:user][:password_confirmation] = Devise.friendly_token[0, 10]
  # end
end
