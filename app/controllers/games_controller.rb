class GamesController < ApplicationController
  include ApplicationHelper
  before_action :check_input

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_back fallback_location: root_path, flash: {notice: "Игра успешно добавлена"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @game.errors.full_messages.join(' ')}
    end
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      @event = Event.new(user_id: current_user.id,
                         what_event: "Установлен счет",
                         game_id: @game.id,
                         player_id: current_user.id,
                         team_id: params[:game][:team_id],
                         score: @game.game_score,
                         time_event: DateTime.now)
      redirect_back fallback_location: root_path, flash: {notice: "Счет установлен"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @game.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @game = Game.find(params[:id])
    if @game.destroy
      redirect_back fallback_location: root_path, flash: {notice: "Игра удалена"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @game.errors.full_messages.join(' ')}
    end
  end

  private

  def game_params
    params.require(:game).permit(:team_one, :team_two, :name, :time, :tournament_id, :location_id, :game_score)
  end

end
