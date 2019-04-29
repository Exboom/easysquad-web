class PlayerTeamsController < ApplicationController

  def new
    @playerteam=PlayerTeam.new
  end

  def edit
    @playerteam=PlayerTeam.find(params[:id])
  end

  def create
    @playerteam=PlayerTeam.new(playerteam_params)
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
    @playerteam = PlayerTeam.find(params[:id])
    @playerteam.destroy

    redirect_to welcome_index_path
  end

  private
  def playerteam_params
    params.require(:playerteam).permit(:olayer, :team)
  end

end
