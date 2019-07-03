class TeamTournamentsController < ApplicationController

  def new
    @team=Team.find(params[:format])
    @teamtournament=TeamTournament.new
  end

  def edit
    @teamtournament=TeamTournament.find(params[:id])
  end

  def create
    session[:return_to] ||= request.referer
    # @team = Team.find(params[:team_tournament][:team])
    @teamtournament=TeamTournament.new(teamtournament_params)
    @teamtournament.save
    redirect_to session.delete(:return_to)
    # redirect_to @team
  end

  def update
    @teamtournament = TeamTournament.find(params[:id])

    if @teamtournament.update(teamtournament_params)
      redirect_to @teamtournament
    else
      render 'show'
    end
  end

  def show
    @teamtournament = TeamTournament.find(params[:id])
  end

  def destroy
    session[:return_to] ||= request.referer
    @teamtournament = TeamTournament.find_by(team_id:params[:id], tournament_id:params[:format])
    if @teamtournament.destroy
      Application.where(tournament_id: params[:format], team_id:params[:id]).destroy_all
    end
    redirect_to session.delete(:return_to)
  end

  private
  def teamtournament_params
    params.require(:team_tournament).permit(:team_id, :tournament_id)
  end

end
