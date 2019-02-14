class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    if user.present?
      can :read, Comment
      can :create, Comment, user_id: user.id
    end

  end

end
