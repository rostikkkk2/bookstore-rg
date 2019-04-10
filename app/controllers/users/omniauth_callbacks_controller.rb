class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  SIGN_IN_FACEBOOK = 'Facebook'.freeze

  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    return sign_in_user(@user) if @user.persisted?

    session['devise.facebook_data'] = request.env['omniauth.auth']
    redirect_to new_user_registration_url
  end

  def sign_in_user(user)
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: SIGN_IN_FACEBOOK) if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end
end
