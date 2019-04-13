class ChangePasswordService
  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def call
    change_old_password if passwords_correct(parse_user_password)
  end

  def passwords_correct(user_password)
    user_password == params[:old_password] && params[:new_password] == params[:confirm_password]
  end

  def change_old_password
    current_user.reset_password(params[:new_password], params[:confirm_password])
  end

  def parse_user_password
    current_secret_key_password = User.find_by(id: current_user.id).encrypted_password
    BCrypt::Password.new(current_secret_key_password)
  end
end
