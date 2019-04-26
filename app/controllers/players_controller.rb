class PlayersController < ApplicationController

  def new
    @player=Player.new
  end

  def edit
    idp=Player.where("user_id = ?", params[:id]).pluck(:id)
    @player=Player.find(idp)
  end

  def create
    # render plain: params[:player].inspect
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
    idp=Player.where("user_id = ?", params[:id]).pluck(:id)

    if Player.find_by_id(idp).nil?
      redirect_to welcome_notplayer_path(current_user)  #это для теста
    else
      @player = Player.find(idp)
    end

    # render plain: params[:player].inspect

    # @player = Player.find(idp)

  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    redirect_to welcome_index_path
  end

  private
  def player_params
    params.require(:player).permit(:name, :birthday, :gamenumber, :user_id)
  end

end
