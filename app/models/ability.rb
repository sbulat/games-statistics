class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, User
      can :manage, Title
      can :manage, Favorite
      can :manage, Game
    elsif user.user?
      can %i[read create], Title
      cannot :accept, Title
      can :manage, Favorite, user_id: user.id
      can :manage, Game, user_id: user.id
    end
  end
end
