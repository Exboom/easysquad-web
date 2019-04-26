class WelcomeController < ApplicationController
  def index
    if Game.take.nil?
      @f=nil
      @games = "В баз нет ни одной игры"
    else
      @f=1
      @games = Game.last(5)
    end
  end

  def notplayer
    @user = current_user.email

    roles = UserRole.where("user1 = ?", params[:format]).pluck(:role)
    teams = UserRole.where("user1 = ?", params[:format]).pluck(:team)

    @userrols = Role.find(roles)

    if teams==[nil] then
      @teams = "Вы не привязаны к какой-либо команде"
      @flag=nil
    else
      @flag=1
      @teams = Team.find(teams)
    end

  end
end
