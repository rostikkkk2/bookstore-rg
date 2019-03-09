class EmailForm
  include ActiveModel::Model
  include Virtus

  attribute :email, String
  attribute :user_id, Integer

  validates :email, :user_id, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def save
    update_email if valid?
  end

  def update_email
    User.find_by(id: user_id).update(email: email)
  end
end
