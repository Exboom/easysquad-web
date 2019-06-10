class WelcomeController < ApplicationController
  before_action :check_input


  def index
    #игры
    @games=Game.all
    @lastgames = Game.where("game_score is not NULL")
    #команды
    @teams=Team.all
    #федерации
    @federations=Federation.all
    #локации
    @locs=Location.all
    #турниры
    @tourns=Tournament.all
    @users = User.all


    @usersNew = User.where("approved = ?", false)

    if current_user!=nil
      @user=User.find(current_user.id)
      @userrols=@user.roles
    end

    # if (@userrols.first.id!=1)
    #   # @team=
    #   search=Team.find(PlayerTeam.where("player = ?", current_user.id).pluck(:team))
    #   @nextgame = Game.where("(team_one = ? OR team_two = ?) AND game_score is NULL", search, search).take
    #   if @nextgame.nil?
    #   else
    #     @app=Application.find_by player:current_user.id, tournament: @nextgame.tournament
    #   end
    # end

  end

  def notplayer

    @teams=Team.all
    #федерации
    @federations=Federation.all
    #локации
    @locs=Location.all
    #турниры
    @tourns=Tournament.all

    @user = User.find(current_user.id)
    @teamsusr=@user.teams
    @rols=@user.roles
    # roles = UserRole.where("user1 = ?", params[:format]).pluck(:role1)
    # @userrols = Role.find(UserRole.where("user1 = ?", params[:format]).pluck(:role1))
    # teams = UserRole.where("user1 = ?", params[:format]).pluck(:team)
    #
    # if (teams.any?) and (teams.to_s != "[nil]")
    #   @teamsusr = Team.find(teams)
    # end

  end

  protected

  def check_input
    unless user_signed_in?
      redirect_to new_user_session_path
    end

    # if user_signed_in?
    #   @user=User.find(current_user.id)
    #   redirect_to new_user_session_path, alert:  "Ваша учетная запись еще не активирована" if @user.approved==false
    # end

  end

  # def check_approved
  #   @user=User.find(current_user.id)
  #   redirect_to new_user_session_path, alert:  "Ваша учетная запись еще не активирована" if @user.approved==false
  # end

end
