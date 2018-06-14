class Ability
  include CanCan::Ability

  def initialize(user)
      can :read, [Tour, Category]
      if user.present?
        can :create, [Booking, Review, Rating]
        can :update, Rating
        can :read, :all
        if user.admin?
          can :manage, :all
        end
      end
  end
end
