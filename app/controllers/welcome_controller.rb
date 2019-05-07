class WelcomeController < ApplicationController
  def index
    #игры
    @games=Game.all
    @lastgames = Game.where("game_score is not NULL")

    search=Team.find(PlayerTeam.where("player = ?", current_user.id).pluck(:team))
    @nextgame = Game.where("(team_one = ? OR team_two = ?) AND game_score is NULL", search, search).take

    if @nextgame.nil?
    else
      @app=Application.find_by player:current_user.id, tournament: @nextgame.tournament
    end

    #команды
    @teams=Team.all

    #федерации
    @federations=Federation.all

    #локации
    @locs=Location.all


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
