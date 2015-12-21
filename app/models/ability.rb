class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    can :manage, Profile
  end
end
