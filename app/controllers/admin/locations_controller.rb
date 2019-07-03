class Admin::LocationsController < ApplicationController
  before_action :check_admin

  def new
    @location=Location.new
  end

  def edit
    @location=Location.find(params[:id])
  end

  def create
    @location=Location.new(location_params)
    @location.save
    redirect_to @location
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      redirect_to @location
    else
      render 'show'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    redirect_to welcome_index_path
  end

  private
  def location_params
    params.require(:location).permit(:name, :address)
  end

  protected

  def check_admin
    @user=User.find(current_user.id)
    @userrols=@user.roles
    redirect_to location_path, alert:  "У Вас нет прав доступа для данных действий" unless @userrols.first.id==1
  end


end
