module PlayersHelper
  def role_in_team (team, player, user)
    team.user_roles.each do |role|
      if player.id == user.id
        if role.user_id == user.id
          return role.role.role
        end
      else
        if role.user_id == player.id
          return role.role.role
        end
      end
    end
  end
end
