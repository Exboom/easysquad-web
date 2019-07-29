# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    @usrrole = user.user_roles

    can :manage, :all if (@usrrole.find_by role: 1).present?
    if (@usrrole.find_by role: 2).present?
      can [:edit, :update], Team, user_id: user.id
      can :team_owner, Team
    end
    if (@usrrole.find_by role: 3).present?
      can [:edit, :update], Team do |team|
        (@usrrole.find_by role_id: 3, team_id: team.id).present?
      end
      can :team_admin, Team
    end
    if (@usrrole.find_by role: 4).present?
      puts user.id
      can [:edit, :update], Player, id: user.id
      can :team_plr, Team
    end
  end
end
