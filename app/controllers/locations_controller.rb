class LocationsController < ApplicationController

  # def new
  #   @location=Location.new
  # end
  #
  # def edit
  #   @location=Location.find(params[:id])
  # end
  #
  # def create
  #   @location=Location.new(location_params)
  #   @location.save
  #   redirect_to @location
  # end
  #
  # def update
  #   @location = Location.find(params[:id])
  #   if @location.update(location_params)
  #     redirect_to @location
  #   else
  #     render 'show'
  #   end
  # end

  def show
    #команды
    @teams=Team.all
    #федерации
    @federations=Federation.all
    #локации
    @locs=Location.all
    #турниры
    @tourns=Tournament.all

    @location = Location.find(params[:id])
  end


  # def destroy
  #   @location = Location.find(params[:id])
  #   @location.destroy
  #
  #   redirect_to welcome_index_path
  # end
  #
  # private
  # def location_params
  #   params.require(:location).permit(:name, :address)
  # end

end
