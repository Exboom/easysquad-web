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
    if @team.save
      UserRole.new(user_id:@team.user,role_id: 2, team_id: @team.id).save
      redirect_to root_path, alert: "Команда успешно создана"
    else
      @team.errors.full_messages.each do |msg|
        puts msg
      end
    end
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
    UserRole.where(team_id: @team).destroy_all
    @team.destroy

    redirect_to welcome_index_path
  end

  private
  def team_params
    params.require(:team).permit(:name, :user_id, :player_id, :default_password)
  end

  protected

  def check_admin
    @user=User.find(current_user.id)
    @userrols=@user.roles
    redirect_to team_path, alert:  "У Вас нет прав доступа для данных действий" unless @userrols.first.id==1
  end

end
