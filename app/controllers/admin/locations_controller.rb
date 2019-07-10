class Admin::LocationsController < ApplicationController
  before_action :check_admin

  def new
    @location = Location.new
  end

  def edit
    @location = Location.find(params[:id])
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to @location, flash: {notice: "Место провдения успешно создано"}
    else
      redirect_to root_path, flash: {"alert-danger": "Произошла ошибка: " + @location.errors.full_messages.join(' ')}
    end
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      redirect_to @location, flash: {notice: "Место провдения успешно обновлено"}
    else
      redirect_to @location, flash: {"alert-danger": "Произошла ошибка: " + @location.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
      redirect_to root_path, flash: {notice: "Место провдения успешно удалено"}
    else
      redirect_to @location, flash: {"alert-danger": "Произошла ошибка: " + @location.errors.full_messages.join(' ')}
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :address)
  end

  protected

  def check_admin
    redirect_to location_path, alert: "У Вас нет прав доступа для данных действий" unless ((@userrols.find_by role: 1) != nil)
  end


end
