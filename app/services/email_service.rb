class EmailService
  attr_reader :email_form, :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
    @email_form = EmailForm.new(params_email)
  end

  def save
    update_email if email_form.valid?
  end

  def update_email
    current_user.update(email_form.attributes.without(:user_id))
  end

  private

  def params_email
    params.permit(:email, :user_id)
  end
end
