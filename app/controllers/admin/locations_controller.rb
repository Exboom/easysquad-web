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

  # def show
  #   tournkey = Tournament.where("location = ?", params[:id]).pluck(:id)
  #   if tournkey.empty?
  #     @f=nil
  #     @tournaments = "На этом месте не проводятся турниры"
  #   else
  #     @f=1
  #     @tournaments = Tournament.find(tournkey)
  #   end
  #   @location = Location.find(params[:id])
  # end

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
    param=UserRole.find_by user1: current_user.id
    @userrols = Role.find(param.role1)
    redirect_to root_path, alert:  "У Вас нет прав доступа к этой странице" unless @userrols.id==1
  end


end
