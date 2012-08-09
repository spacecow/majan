class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :show, User
    end
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
  end
end
