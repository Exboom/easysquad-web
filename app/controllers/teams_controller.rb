class TeamsController < ApplicationController

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
  # def update
  #   @team = Team.find(params[:id])
  #
  #   if @team.update(team_params)
  #     redirect_to @team
  #   else
  #     render 'show'
  #   end
  # end

  def show
    #команды
    @teams=Team.all
    #федерации
    @federations=Federation.all
    #локации
    @locs=Location.all
    #турниры
    @tourns=Tournament.all

    @team = Team.find(params[:id])
    @owner = @team.user
    @cap=@team.player

    @user=User.find(current_user.id)
    @userrols=@user.roles

  end

  # def destroy
  #   @team = Team.find(params[:id])
  #   @team.destroy
  #
  #   redirect_to welcome_index_path
  # end
  #
  # private
  # def team_params
  #   params.require(:team).permit(:name, :owner, :captain)
  # end

end
