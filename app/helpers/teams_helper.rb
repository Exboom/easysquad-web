module TeamsHelper
  def tourn_team_out(user, owner, usrrl, team, tourn)
    if (user.id == owner.id) or ((usrrl.find_by team_id: team.id, user_id: user.id, role_id: 3) != nil) or ((usrrl.find_by role: 1) != nil)
      link_to "Выйти из турнира", team_tournament_path(team, tourn), :method => :delete, :class => "btn btn-secondary"
    end
  end

  def tourn_team_newapp(user, owner, usrrl, team, tourn)
    if (user.id == owner.id) or ((usrrl.find_by team_id: team.id, user_id: user.id, role_id: 3) != nil) or ((usrrl.find_by role: 1) != nil)
      link_to "Создать заявку", appfortourn_path(:team => team, :tourn => tourn), :method => :get, :class => "btn btn-secondary"
    end
  end

  def plr_team_out(user, owner, usrrl, team, play)
    if (user.id == owner.id) or ((usrrl.find_by role: 1) != nil) or ((usrrl.find_by team_id: team.id, user_id: user.id, role_id: 3) != nil)
      link_to 'Убрать из команды', player_team_path(play, team), method: :delete, :class => "btn btn-secondary"
    end
  end

  def new_app (player, form)
    if player.empty?
      return "Нет доступных к заявке игроков"
    else
      return form.collection_check_boxes(:player_id, player, :id, :name, {}, {:class => "form-control checkbox inline"})
    end
  end

  def new_tourn_team(user, owner, usrrl, team)
    if (user.id == owner.id) or ((usrrl.find_by team_id: team.id, user_id: user.id, role_id: 3) != nil) or ((usrrl.find_by role: 1) != nil)
      render partial: "new_tourn", locals: {team: team}
    end
  end

  def cap_team(cap)
    if cap.nil?
      return "капитан не назначен"
    else
      return cap.name
    end
  end

end
