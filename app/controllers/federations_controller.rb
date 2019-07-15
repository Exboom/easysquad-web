class FederationsController < ApplicationController

  def index
    @federations_page = (Federation.all.size/10.0).ceil
    if params[:offset].nil?
      @federations = Federation.limit(10).offset(0)
    else
      @federations = Federation.limit(10).offset(params[:offset].to_i*10)
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @federation = Federation.find(params[:id])
  end

end
