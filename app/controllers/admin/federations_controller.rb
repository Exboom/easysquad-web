class Admin::FederationsController < ApplicationController

  include ApplicationHelper
  before_action :check_admin

  def new
    @federation = Federation.new
  end

  def edit
    @federation = Federation.find(params[:id])
  end

  def create
    @federation = Federation.new(federation_params)
    if @federation.save
      redirect_to @federation, flash: {notice: "Федерация успешно создана"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @federation.errors.full_messages.join(' ')}
    end
  end

  def update
    @federation = Federation.find(params[:id])
    if @federation.update(federation_params)
      redirect_to @federation, flash: {notice: "Федерация успешно обновлена"}
    else
      redirect_back fallback_location: @federation, flash: {"alert-danger": "Произошла ошибка: " + @federation.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @federation = Federation.find(params[:id])
    if @federation.destroy
      redirect_to root_path, flash: {notice: "Федерация удалена"}
    else
      redirect_back fallback_location: @federation, flash: {"alert-danger": "Произошла ошибка: " + @federation.errors.full_messages.join(' ')}
    end
  end

  private

  def federation_params
    params.require(:federation).permit(:name, :url, :contacts, :description)
  end

end
