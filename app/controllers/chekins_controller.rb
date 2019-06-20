class ChekinsController < ApplicationController

  def new
    @player=Player.find(current_user.id)
    @chekin=Chekin.new
    @game=Game.find(params[:format])
    @lastchekin=Chekin.find_by player:@player, game: @game
  end

  def edit
    @chekin=Chekin.find(params[:id])
    @player=@chekin.player
    @game=@chekin.game
    @team=@chekin.team
  end

  def create
    @chekin=Chekin.new(chekin_params)
    if @chekin.save
     # redirect_to @chekin
     redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @chekin = Chekin.find(params[:id])

    if @chekin.update(chekin_params)
      # redirect_to @chekin
      redirect_to root_path
    else
      render 'show'
    end
  end

  def show
    @chekin = Chekin.find(params[:id])
    @player=@chekin.player
    @game=@chekin.game
    @team=@chekin.team
    @reason=@chekin.reason
  end

  def destroy
    @chekin = Chekin.find(params[:id])
    @chekin.destroy

    redirect_to welcome_index_path
  end

  private
  def chekin_params
    params.require(:chekin).permit(:player_id, :team_id, :game_id, :chekin, :reason_id, :presence, :comment)
  end
  
end
