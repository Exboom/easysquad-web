class LocationsController < ApplicationController

  def index
    @locations_page = (Location.all.size/10.0).ceil
    if params[:offset].nil?
      @locations = Location.limit(10).offset(0)
    else
      @locations = Location.limit(10).offset(params[:offset].to_i*10)
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @location = Location.find(params[:id])
  end

end
