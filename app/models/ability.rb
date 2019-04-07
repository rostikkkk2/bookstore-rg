class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user
      can :create, Comment, user_id: user.id
      can :manage, User, id: user.id
      can %i[read create], Order
      can %i[create update destroy], LineItem
      can %i[read create update], [Order, Address, CreditCard], user_id: user.id
    else
      cannot :read, Order do |order|
        order.invisible?
      end
      can %i[create destroy], Order
      can %i[create update destroy], LineItem
      can :update, Book
      cannot %i[read update create], Address
    end
  end
end
