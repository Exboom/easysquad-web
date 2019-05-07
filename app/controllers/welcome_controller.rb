class WelcomeController < ApplicationController
  def index
    if Game.take.nil?
      @f=nil
      @games = "В базе нет ни одной игры"
      @nextgame = @games
    else
      @f=1
      @games = Game.where("game_score is not NULL")

      search=Team.find(PlayerTeam.where("player = ?", current_user.id).pluck(:team))
      @nextgame = Game.where("(team_one = ? OR team_two = ?) AND game_score is NULL", search, search).take

      if @nextgame.nil?
        @f0=1
        @nextgame = "В ближайшее время игр нет"
      end


      @app=Application.find_by player:current_user.id, tournament: @nextgame.tournament
    end


    if Team.take.nil?
      @f1=nil
      @teams = "В баз нет ни одной команды!"
    else
      @f1=1
      @teams=Team.all
    end

    if Federation.take.nil?
      @f2=nil
      @federations = "В баз нет ни одной федерации!"
    else
      @f2=1
      @federations=Federation.all
    end

    if Location.take.nil?
      @f3=nil
      @tourn = "В баз нет ни одного места!"
    else
      @f3=1
      @tourn=Location.all
    end

    @users=User.all
  end

  def notplayer
    @user = current_user.email

    roles = UserRole.where("user1 = ?", params[:format]).pluck(:role)
    teams = UserRole.where("user1 = ?", params[:format]).pluck(:team)

    @userrols = Role.find(roles)

    if teams.empty? then
      @teams = "Вы не привязаны к какой-либо команде"
      @flag=nil
    else
      @flag=1
      @teams = Team.find(teams)
    end

  end
end
