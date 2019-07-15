class TournamentsController < ApplicationController

  def index
    @tournaments_page = (Tournament.all.size/10.0).ceil
    if params[:offset].nil?
      @tournaments = Tournament.limit(10).offset(0)
    else
      @tournaments = Tournament.limit(10).offset(params[:offset].to_i*10)
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

end
