class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    user_access if @user
  end

private

  def user_access
    can :manage, Baza::Database
    can :manage, Baza::Column
    can :manage, Baza::Index
    can :manage, Baza::Row
    can :manage, Baza::Table

    can :manage, Profile
  end
end
