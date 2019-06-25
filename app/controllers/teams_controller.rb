class TeamsController < ApplicationController

  before_action :check_owner, only: [:edit]

  # def index
  #   @teams=Team.all
  # end
  #
  # def new
  #   @team=Team.new
  #   @users=User.all
  # end
  #
  def edit
    @team=Team.find(params[:id])
  end
  #
  # def create
  #   @team=Team.new(team_params)
  #   @team.save
  #   redirect_to @team
  # end
  #
  def update
    @team = Team.find(params[:id])

    if @team.update(team_params)
      redirect_to @team
    else
      render 'edit'
    end
  end

  def show
    @team = Team.find(params[:id])
    @owner = @team.user
    @cap=@team.player
    @teamadmins=@team.user_roles.where(role_id: 3)
    @cnd=@team.user_roles.where.not(role_id: 3).where.not(role_id: 2)
    @candidates=Array.new(@cnd.size)
    @cnd.each_with_index do |cnd, index|
      if @teamadmins[0].nil?
        @candidates[index]=Player.find(cnd.user_id)
      else
        @teamadmins.each do |tmadm|
          if tmadm.user_id==cnd.user_id
            next
          else
            @candidates[index]=Player.find(cnd.user_id)
          end
        end
      end
    end

  end

  # def destroy
  #   @team = Team.find(params[:id])
  #   @team.destroy
  #
  #   redirect_to welcome_index_path
  # end

  private
  def team_params
    params.require(:team).permit(:name, :user_id, :player_id)
  end

  def check_owner
    @team = Team.find(params[:id])
    redirect_to team_path,
                alert:  "У Вас нет прав доступа для данных действий" unless (current_user.id==@team.user_id) or !(@userrols.find_by_id(1).nil?)
  end


end
