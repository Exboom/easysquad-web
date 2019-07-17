module PlayersHelper
  def role_in_team (team, player, user)
    if player.id==user.id
      user.user_roles.where(team_id: team.id)
    else
      user=User.find(player.id)
      user.user_roles.where(team_id: team.id)
    end
  end
end
