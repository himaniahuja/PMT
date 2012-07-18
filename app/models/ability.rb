#== This class defines abilities for the different roles in devise.
class Ability
  include CanCan::Ability
# 1. Admin can perform all actions
# 2. Project Manager can add and view users and projects and can update his projects which are not finished but cannot delete a user or project.
# 3. Developer can view all projects and users but cannot add, update or delete projects or users.

  def initialize(user)

    if user.role == 'admin'
      can :manage, :all

    elsif user.role == 'manager'
      can [:show, :new, :create, :dropdown_update], Project
	  can [:edit, :update, :destroy, :archive], Project, :owner => user.id
	  can [:manage, :all], [Phase, Deliverable]
	  can [:manage, :all], User


    elsif user.role == 'developer'
      can [:show, :dropdown_update], Project
      can [:show, :all], User
      can :toggle_is_done, Deliverable

	  cannot [:create, :update, :destroy], [Phase, Deliverable]
      cannot :create, User

    end
  end
end


