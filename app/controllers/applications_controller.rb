class ApplicationsController < ApplicationController

  def new
    @application=Application.new
    @player=Player.find(params[:format])
  end

  def edit
    @application=Application.find(params[:id])
    @player=Player.find(Application.find(params[:id]).player)
  end

  def create
    @application=Application.new(application_params)
    @application.save
    redirect_to @application
  end

  def update
    @application = Application.find(params[:id])

    if @application.update(application_params)
      redirect_to @application
    else
      render 'show'
    end
  end

  def show
    @application = Application.find(params[:id])
    @player=@application.player
    @team=@application.team
    @tourn=@application.tournament
  end

  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    redirect_to welcome_index_path
  end

  private
  def application_params
    params.require(:application).permit(:player_id, :team_id, :tournament_id)
  end
  
end
