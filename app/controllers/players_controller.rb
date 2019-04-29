class PlayersController < ApplicationController

  def new
    @player=Player.new
  end

  def edit
    @player=Player.find(params[:id])
  end

  def create
    @player=Player.new(player_params)
    @player.save
    redirect_to @player
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
    @applications=Application.where("player = ?", params[:id]).pluck(:id)



    if Player.find_by_id(params[:id]).nil?
      redirect_to welcome_notplayer_path(current_user)  #это для теста
    else
      @player = Player.find(params[:id])
    end
    teams = PlayerTeam.where("player = ?", params[:id]).pluck(:team)
    @teams = Team.find(teams)

  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    redirect_to welcome_index_path
  end

  private
  def player_params
    params.require(:player).permit(:name, :birthday, :gamenumber, :id)
  end

end
