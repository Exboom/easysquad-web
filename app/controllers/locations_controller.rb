class LocationsController < ApplicationController
  include ApplicationHelper
  before_action :check_input

  def index
    @locations_page = (Location.all.size / 13.0).ceil
    if params[:offset].nil?
      @locations = Location.limit(13).offset(0)
    else
      @locations = Location.limit(13).offset(params[:offset].to_i * 13)
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @location = Location.find(params[:id])
  end

end
