# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    @usrrole = user.user_roles
    if (@usrrole.find_by role: 1).present?
      can :manage, :all
    elsif (@usrrole.find_by role: 2).present?
      can :manage, Team, user_id: user.id
    elsif (@usrrole.find_by role: 3).present?
      can [:edit, :update], Team do |team|
        (@usrrole.find_by role_id: 3, team_id: team).present?
      end
    elsif (@usrrole.find_by role: 4).present?
      can [:edit, :update], Player do |player|
        player.id==user.id
      end
    end
  end
end
