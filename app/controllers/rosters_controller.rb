class RostersController < ApplicationController

  def create
    @application = Roster.new(application_params)
    @application.save
    redirect_to @application
  end

  def update
    @application = Roster.find(params[:id])
    if @application.update(application_params)
      redirect_to @application
    else
      render 'show'
    end
  end

  def destroy
    @application = Roster.find(params[:id])
    @application.destroy
    redirect_to root_path
  end

  private

  def application_params
    params.require(:application).permit(:player_id, :team_id, :tournament_id)
  end

end
