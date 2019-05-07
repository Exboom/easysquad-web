class ChekinsController < ApplicationController

  def new
    @player=Player.find(current_user.id)
    @chekin=Chekin.new
    @game=Game.find(params[:format])
    @lastchekin=Chekin.find_by player:@player, game: @game

    # if @lastchekin.nil?
    # else
    #
    #   render 'show'
    # end
  end

  def edit
    @chekin=Chekin.find(params[:id])
    @player = Player.find(@chekin.player)
    @game = Game.find(@chekin.game)
    @team = Team.find(@chekin.team)
  end

  def create
    @chekin=Chekin.new(chekin_params)
    @chekin.save
    redirect_to @chekin
  end

  def update
    @chekin = Chekin.find(params[:id])

    if @chekin.update(chekin_params)
      redirect_to @chekin
    else
      render 'show'
    end
  end

  def show
    @chekin = Chekin.find(params[:id])
    @player = Player.find(@chekin.player)
    @game = Game.find(@chekin.game)
    @team = Team.find(@chekin.team)
    if @chekin.reasons!=nil
      @reason = Reason.find(@chekin.reasons)
    end
  end

  def destroy
    @chekin = Chekin.find(params[:id])
    @chekin.destroy

    redirect_to welcome_index_path
  end

  private
  def chekin_params
    params.require(:chekin).permit(:player, :team, :game, :chekin, :chekin_date, :reasons, :presence, :comment)
  end
  
end
