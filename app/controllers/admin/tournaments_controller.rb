class Admin::TournamentsController < ApplicationController
  include ApplicationHelper
  before_action :check_admin

  def new
    @tournament = Tournament.new
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def create
    @tournament = Tournament.new(tournament_params)
    @lct = params[:tournament][:location_id]
    if @tournament.save
      @lct.each do |lct|
        if lct.nil? or lct == ""
          next
        else
          @tournament.locations << Location.find(lct)
        end
      end
      redirect_to @tournament, flash: {notice: "Турнир успешно создан"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @tournament.errors.full_messages.join(' ')}
    end
  end

  def update
    @tournament = Tournament.find(params[:id])
    @lct = params[:tournament][:location_id]
    if @tournament.update(tournament_params)
      @lct.each do |lct|
        if lct.nil? or lct == ""
          next
        else
          @tournament.locations << Location.find(lct)
        end
        @tournament.locations = @tournament.locations.uniq
      end
      redirect_to @tournament, flash: {notice: "Турнир успешно обновлен"}
    else
      redirect_back fallback_location: @tournament, flash: {"alert-danger": "Произошла ошибка: " + @tournament.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    if @tournament.destroy
      redirect_to root_path, flash: {notice: "Турнир успешно обновлен"}
    else
      redirect_back fallback_location: @tournament, flash: {"alert-danger": "Произошла ошибка: " + @tournament.errors.full_messages.join(' ')}
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :season, :federation_id)
  end

end
