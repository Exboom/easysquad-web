class PlayerTeamsController < ApplicationController

  def new
    @team=Team.find(params[:format])
    @playerteam=PlayerTeam.new
  end

  def edit
    @playerteam=PlayerTeam.find(params[:id])
  end

  def create
    @team = Team.find(params[:player_team][:team_id])
    @playerteam=PlayerTeam.new(playerteam_params)
    if @playerteam.save
      UserRole.new(user_id: params[:player_team][:player_id], role_id:4, team_id: params[:player_team][:team_id]).save
    end
    redirect_to @team, alert:  "Игрок добавлен в команду"
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
    session[:return_to] ||= request.referer
    @playerteam = PlayerTeam.find_by player: params[:id], team: params[:format]
    @userroletm = UserRole.find_by user: params[:id], team: params[:format], role: 4
    @playerteam.destroy
    @userroletm.destroy
    redirect_to session.delete(:return_to), alert:  "Игрок удален из команды"
  end

  private
  def playerteam_params
    params.require(:player_team).permit(:player_id, :team_id)
  end

end
