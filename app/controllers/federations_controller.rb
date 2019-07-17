class FederationsController < ApplicationController

  def index
    @federations_page = (Federation.all.size/13.0).ceil
    if params[:offset].nil?
      @federations = Federation.limit(13).offset(0)
    else
      @federations = Federation.limit(13).offset(params[:offset].to_i*13)
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @federation = Federation.find(params[:id])
  end

end
