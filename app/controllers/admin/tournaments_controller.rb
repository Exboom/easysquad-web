class Admin::TournamentsController < ApplicationController
  before_action :check_admin

  def new
    @tournament=Tournament.new
  end

  def edit
    @tournament=Tournament.find(params[:id])
  end

  def create
    @tournament=Tournament.new(tournament_params)
    @lct=params[:tournament][:location_id]
    if @tournament.save
      @lct.each do |lct|
        if lct.nil? or lct==""
          next
        else
          @tournament.locations<<Location.find(lct)
        end
      end
    end
    redirect_to @tournament
  end

  def update
    @tournament = Tournament.find(params[:id])
    @lct=params[:tournament][:location_id]
    if @tournament.update(tournament_params)
      @lct.each do |lct|
        if lct.nil? or lct==""
          next
        else
          @tournament.locations<<Location.find(lct)
        end
      end
      redirect_to @tournament
    else
      render 'show'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.team_tournaments.destroy_all
    @tournament.applications.destroy_all
    @tournament.games.each do |game|
      game.chekins.destroy_all
    end
    @tournament.games.destroy_all
    @tournament.locations.clear
    @tournament.destroy
    redirect_to welcome_index_path
  end

  private
  def tournament_params
    params.require(:tournament).permit(:name, :season, :federation_id)
  end

  protected

  def check_admin
    @user=User.find(current_user.id)
    redirect_to tournament_path, alert:  "У Вас нет прав доступа для данных действий" unless ((@userrols.find_by role: 1)!=nil)
  end

end
