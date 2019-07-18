class TeamTournamentsController < ApplicationController

  def create
    @teamtournament = TeamTournament.new(teamtournament_params)
    if @teamtournament.save
      redirect_back fallback_location: root_path, flash: {notice: "Турнир добавлен"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @teamtournament.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @teamtournament = TeamTournament.find_by(team_id: params[:id], tournament_id: params[:format])
    if @teamtournament.destroy
      Roster.where(tournament_id: params[:format], team_id: params[:id]).destroy_all
      redirect_back fallback_location: root_path, flash: {notice: "Участие в турнире отменено"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @teamtournament.errors.full_messages.join(' ')}
    end
  end

  private

  def teamtournament_params
    params.require(:team_tournament).permit(:team_id, :tournament_id)
  end

end
