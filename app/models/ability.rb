class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    can :read, :all
    if user.present?
      can :create, Comment, user_id: user.id
      can :manage, User, id: user.id
    end
    can %i[create destroy], Order
    can %i[create update destroy], LineItem
    can :update, Book
  end

end
