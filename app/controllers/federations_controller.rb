class FederationsController < ApplicationController

  def index
    @federations = Federation.all
    @federations = Federation.limit(10)
  end

  def show
    @federation = Federation.find(params[:id])
  end

end
