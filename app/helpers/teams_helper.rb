module TeamsHelper
  def tourn_team_out(team, tourn)
    if can? :edit, team
      link_to "Выйти из турнира", team_tournament_path(team, tourn), :method => :delete, :class => "btn btn-secondary"
    end
  end

  def tourn_team_newapp(team, tourn)
    if can? :edit, team
      link_to "Заявка", appfortourn_path(:team => team, :tourn => tourn), :method => :get, :class => "btn btn-secondary"
    end
  end

  def plr_team_out(team, play)
    if can? :edit, team
      link_to 'Убрать из команды', player_team_path(play, team), method: :delete, :class => "btn btn-secondary"
    end
  end

  def new_tourn_team(team)
    if can? :edit, team
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

  def owner_team(owner)
    if owner.nil?
      return "владелец не назначен"
    else
      return owner.email
    end
  end

  def admin_pan_team(team)
    if (@userrols.find_by role: 1).present?
      return (link_to edit_admin_team_path(team), :method => :get,
                      :class => "close-link",
                      "data-toggle" => "tooltip",
                      "data-placement" => "top",
                      :title => "",
                      "data-original-title" => "Редактировать команду" do
        content_tag(:i, "", class: "fa fa-gears")
      end)
    end
  end

end
