class PlayersController < ApplicationController

  def new
    @player=Player.new
  end

  def edit
    @player=Player.find(params[:id])
  end

  def create
    @player=Player.new(player_params)
  end

  def update
    @player = Player.find(params[:id])

    if @player.update(player_params)
      redirect_to @player
    else
      render 'show'
    end
  end

  def show
    @player = Player.find([:id])
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    redirect_to welcome_index_path
  end

  private
  def player_params
    params.require(:player).permit(:name, :birthday, :gamenumber)
  end

end
