class TeamTournamentsController < ApplicationController

  def new
    @teamtournament=TeamTournament.new
  end

  def edit
    @teamtournament=TeamTournament.find(params[:id])
  end

  def create
    @teamtournament=TeamTournament.new(teamtournament_params)
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
    @teamtournament = TeamTournament.find([:id])
  end

  def destroy
    @teamtournament = TeamTournament.find(params[:id])
    @teamtournament.destroy

    redirect_to welcome_index_path
  end

  private
  def teamtournament_params
    params.require(:teamtournament).permit(:team, :tournament)
  end

end
