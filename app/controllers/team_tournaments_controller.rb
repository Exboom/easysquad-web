class TeamTournamentsController < ApplicationController

  def create
    session[:return_to] ||= request.referer
    @teamtournament = TeamTournament.new(teamtournament_params)
    if @teamtournament.save
      redirect_to session.delete(:return_to), flash: {notice: "Турнир добавлен"}
    else
      redirect_to session.delete(:return_to), flash: {"alert-danger": "Произошла ошибка: " + @teamtournament.errors.full_messages.join(' ')}
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @teamtournament = TeamTournament.find_by(team_id: params[:id], tournament_id: params[:format])
    if @teamtournament.destroy
      Application.where(tournament_id: params[:format], team_id: params[:id]).destroy_all
      redirect_to session.delete(:return_to), flash: {notice: "Участие в турнире отменено"}
    else
      redirect_to session.delete(:return_to), flash: {"alert-danger": "Произошла ошибка: " + @teamtournament.errors.full_messages.join(' ')}
    end
  end

  private

  def teamtournament_params
    params.require(:team_tournament).permit(:team_id, :tournament_id)
  end

end
