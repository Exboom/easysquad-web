class FederationsController < ApplicationController

  def show
    @federation = Federation.find(params[:id])
  end

end
