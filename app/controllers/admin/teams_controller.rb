class Admin::TeamsController < ApplicationController
  before_action :check_admin

  def index
    @teams=Team.all
  end

  def new
    @team=Team.new
    @users=User.all
  end

  # def edit
  #   @team=Team.find(params[:id])
  # end

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

  # def show
  #   @tourns=Tournament.find(TeamTournament.where("team = ?", params[:id]).pluck(:team))
  #
  #   @team = Team.find(params[:id])
  #   @owner = User.find(@team.owner)
  #   if @team.captain!=nil
  #     @cap = Player.find(@team.captain)
  #   end
  #   players = PlayerTeam.where("team = ?", params[:id]).pluck(:player)
  #   @players = Player.find(players)
  # end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to welcome_index_path
  end

  private
  def team_params
    params.require(:team).permit(:name, :owner, :captain)
  end

  protected

  def check_admin
    param=UserRole.find_by user1: current_user.id
    @userrols = Role.find(param.role1)
    redirect_to team_path, alert:  "У Вас нет прав доступа для данных действий" unless @userrols.id==1
  end

end