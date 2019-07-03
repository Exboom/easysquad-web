class Admin::TeamsController < ApplicationController
  before_action :check_admin

  def index
    @teams=Team.all
  end

  def new
    @team=Team.new
    @users=User.all
  end

  def edit
    @team=Team.find(params[:id])
  end

  def create
    @team=Team.new(team_params)
    @team.save
    redirect_to @team
  end

  def update
    @team = Team.find(params[:id])

    if @team.update(team_params)
      redirect_to @team
    else
      render 'show'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.player_teams.destroy_all
    @team.team_tournaments.destroy_all
    Game.where(team_one: @team)or(Game.where(team_two: @team)).destroy_all
    @team.applications.destroy_all
    @team.destroy

    redirect_to welcome_index_path
  end

  private
  def team_params
    params.require(:team).permit(:name, :user_id, :player_id)
  end

  protected

  def check_admin
    @user=User.find(current_user.id)
    @userrols=@user.roles
    redirect_to team_path, alert:  "У Вас нет прав доступа для данных действий" unless @userrols.first.id==1
  end

end
