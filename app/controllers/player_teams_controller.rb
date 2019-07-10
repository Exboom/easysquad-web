class PlayerTeamsController < ApplicationController

  def create
    @team = Team.find(params[:player_team][:team_id])
    @playerteam = PlayerTeam.new(playerteam_params)
    if @playerteam.save
      UserRole.new(user_id: params[:player_team][:player_id], role_id: 4, team_id: params[:player_team][:team_id]).save
      redirect_to @team, flash: {notice: "Игрок добавлен в команду"}
    else
      redirect_to @team, flash: {"alert-danger": "Произошла ошибка: " + @playerteam.errors.full_messages.join(' ')}
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @playerteam = PlayerTeam.find_by player: params[:id], team: params[:format]
    @userroletm = UserRole.find_by user: params[:id], team: params[:format], role: 4
    if @playerteam.destroy
      @userroletm.destroy
      redirect_to session.delete(:return_to), alert: "Игрок удален из команды"
    else
      redirect_to session.delete(:return_to), flash: {"alert-danger": "Произошла ошибка: " + @playerteam.errors.full_messages.join(' ')}
    end
  end

  private

  def playerteam_params
    params.require(:player_team).permit(:player_id, :team_id)
  end

end
