class GamesController < ApplicationController

  def new
    @game=Game.new
  end

  def edit
    @game=Game.find(params[:id])
  end

  def create
    @game=Game.new(game_params)
    @game.save
    redirect_to @game
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
    @game = Game.find(params[:id])
    @app=Application.find_by player:current_user.id, tournament: @game.tournament
    @players=Player.find(Chekin.where("game = ?", @game.id).pluck( :player))
    @team1=Team.find(@game.team_one)
    @team2=Team.find(@game.team_two)
    @tourn=Tournament.find(@game.tournament)
    if Game.find(params[:id]).game_score.nil?
      @f=nil
    else
      @f=1
    end
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
