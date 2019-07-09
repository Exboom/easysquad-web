class Admin::FederationsController < ApplicationController
  before_action :check_admin

  def new
    @federation=Federation.new
  end

  def edit
    @federation=Federation.find(params[:id])
  end

  def create
    @federation=Federation.new(federation_params)
    if @federation.save
      redirect_to @federation, flash: {notice: "Федерация успешно создана"}
    else
      redirect_to root_path, flash: {"alert-danger": "Произошла ошибка: "+ @federation.errors.full_messages.join(' ')}
    end
  end

  def update
    @federation = Federation.find(params[:id])
    if @federation.update(federation_params)
      redirect_to @federation, flash: {notice: "Федерация успешно обновлена"}
    else
      redirect_to @federation, flash: {"alert-danger": "Произошла ошибка: "+ @federation.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @federation = Federation.find(params[:id])
    @tournaments=@federation.tournaments
    @tournaments.each do |tourn|
      tourn.team_tournaments.destroy_all
      tourn.games.each do |game|
        game.chekins.destroy_all
      end
    end
    @tournaments.destroy_all
    @federation.destroy
    redirect_to root_path, alert: "Федеарция успешно удалена"
  end

  private
  def federation_params
    params.require(:federation).permit(:name, :url, :contacts)
  end

  protected

  def check_admin
    redirect_to federation_path, alert:  "У Вас нет прав доступа для данных действий" unless ((@userrols.find_by role: 1)!=nil)
  end

end
