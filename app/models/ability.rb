class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :show, User
      if user.role? :admin
        can [:create,:destroy], Day
      end
    end
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
  end
end
