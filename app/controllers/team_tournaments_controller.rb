class TeamTournamentsController < ApplicationController

  def new
    @team=Team.find(params[:format])
    @teamtournament=TeamTournament.new
  end

  def edit
    @teamtournament=TeamTournament.find(params[:id])
  end

  def create
    @team = Team.find(params[:team_tournament][:team])
    @teamtournament=TeamTournament.new(teamtournament_params)
    @teamtournament.save
    redirect_to @team
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
    @teamtournament = TeamTournament.find(params[:id])
    @teamtournament.destroy

    redirect_to welcome_index_path
  end

  private
  def teamtournament_params
    params.require(:team_tournament).permit(:team, :tournament)
  end

end
