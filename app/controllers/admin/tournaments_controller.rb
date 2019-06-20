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
    @tournament.save
    redirect_to @tournament
  end

  def update
    @tournament = Tournament.find(params[:id])

    if @tournament.update(tournament_params)
      redirect_to @tournament
    else
      render 'show'
    end
  end

  # def show
  #   @local=Location.find(Tournament.find(params[:id]).location)
  #   @feder=Federation.find(Tournament.find(params[:id]).federation)
  #   @tournament = Tournament.find(params[:id])
  #   # @team
  # end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy

    redirect_to welcome_index_path
  end

  private
  def tournament_params
    params.require(:tournament).permit(:name, :season, :location_id, :federation_id)
  end

  protected

  def check_admin
    @user=User.find(current_user.id)
    @userrols=@user.roles
    redirect_to tournament_path, alert:  "У Вас нет прав доступа для данных действий" unless @userrols.first.id==1
  end

end
