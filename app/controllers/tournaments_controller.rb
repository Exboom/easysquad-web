class TournamentsController < ApplicationController

  def index
    @tournaments_page = (Tournament.all.size/13.0).ceil
    if params[:offset].nil?
      @tournaments = Tournament.limit(13).offset(0)
    else
      @tournaments = Tournament.limit(13).offset(params[:offset].to_i*13)
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

end
