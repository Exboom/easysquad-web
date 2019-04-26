class ChekinsController < ApplicationController

  def new
    @chekin=Chekin.new
  end

  def edit
    @chekin=Chekin.find(params[:id])
  end

  def create
    @chekin=Chekin.new(chekin_params)
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
    @chekin = Chekin.find([:id])
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
