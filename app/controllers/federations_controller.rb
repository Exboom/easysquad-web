class FederationsController < ApplicationController

  # def new
  #   @federation=Federation.new
  # end
  #
  # def edit
  #   @federation=Federation.find(params[:id])
  # end
  #
  # def create
  #   @federation=Federation.new(federation_params)
  #   @federation.save
  #   redirect_to @federation
  # end
  #
  # def update
  #   @federation = Federation.find(params[:id])
  #
  #   if @federation.update(federation_params)
  #     redirect_to @federation
  #   else
  #     render 'show'
  #   end
  # end

  def show
    tournkey= Tournament.where("federation = ?", params[:id]).pluck(:id)

    if tournkey.empty?
      @f=nil
      @tournaments = "Эта федерация не проводит турниров"
    else
      @f=1
      @tournaments= Tournament.find(tournkey)
    end

    @federation = Federation.find(params[:id])
  end

  # def destroy
  #   @federation = Federation.find(params[:id])
  #   @federation.destroy
  #
  #   redirect_to welcome_index_path
  # end
  #
  # private
  # def federation_params
  #   params.require(:federation).permit(:name, :url, :contacts)
  # end

end
