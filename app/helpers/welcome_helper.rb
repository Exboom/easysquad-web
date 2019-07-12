module WelcomeHelper
  def whose_event_nscore(hstr)
    if hstr.admin == true
      if Player.where(id: (hstr.user_id)).empty?
        return hstr.user.email + "(admin)"
      else
        return hstr.player.name + "(admin)"
      end
    else
      return hstr.player.name
    end
  end

  def whose_event_score(hstr)
    if Player.where(id: (hstr.user_id)).empty?
      return hstr.user.email + "(admin)"
    else
      return hstr.player.name + "(admin)"
    end
  end

  def value_event (hstr)
    if hstr.checkin == false
      if Reason.find_by(id: hstr.reason_id).nil?
      else
        return "|" + Reason.find_by(id: hstr.reason_id).reason
      end
    end
  end

  def notplayer_team_role(team, user)
    team.user_roles.each do |role|
      if role.user_id == user.id
        return role.role.role
      end
    end
  end
end
