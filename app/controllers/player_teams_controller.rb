class PlayerTeamsController < ApplicationController

  def new
    @team=Team.find(params[:format])
    @playerteam=PlayerTeam.new
  end

  def edit
    @playerteam=PlayerTeam.find(params[:id])
  end

  def create
    @team = Team.find(params[:player_team][:team])
    @playerteam=PlayerTeam.new(playerteam_params)
    @playerteam.save
    redirect_to @team
  end

  def update
    @playerteam = PlayerTeam.find(params[:id])

    if @playerteam.update(playerteam_params)
      redirect_to @playerteam
    else
      render 'show'
    end
  end

  def show
    @playerteam = PlayerTeam.find(params[:id])
  end

  def destroy
    @playerteam = PlayerTeam.find_by player: params[:id], team: params[:format]
    # @playerteam = PlayerTeam.where("player = ? AND team=?", params[:id],params[:format])
    @playerteam.destroy
    # PlayerTeam.destroy(PlayerTeam.find_by player: params[:id], team: params[:format])

    redirect_to welcome_index_path
  end

  private
  def playerteam_params
    params.require(:player_team).permit(:player, :team)
  end

end
