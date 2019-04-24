class GamesController < ApplicationController

  def new
    @game=Game.new
  end

  def edit
    @game=Game.find(params[:id])
  end

  def create
    @game=Game.new(game_params)
  end

  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      redirect_to @game
    else
      render 'show'
    end
  end

  def show
    @game = Game.find([:id])
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    redirect_to welcome_index_path
  end

  private
  def game_params
    params.require(:game).permit(:team_one, :team_two, :name, :time, :tournament, :game_score)
  end

end
