class ChekinsController < ApplicationController
  include ApplicationHelper
  before_action :check_input

  def edit
    @chekin = Chekin.find(params[:id])
    @player = @chekin.player
    @game = @chekin.game
    @team = @chekin.team
  end

  def create
    @chekin = Chekin.new(chekin_params)
    if @chekin.save
      @event = Event.new(user_id: current_user.id,
                         player_id: @chekin.player_id,
                         what_event: "Отметка на игру",
                         checkin: @chekin.chekin,
                         admin: params[:chekin][:admin],
                         reason_id: params[:chekin][:reason_id],
                         team_id: @chekin.team_id,
                         game_id: @chekin.game_id,
                         time_event: DateTime.now)
      redirect_back fallback_location: root_path, flash: {notice: "Отметка произведена успешно"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @chekin.errors.full_messages.join(' ')}
    end
  end

  def update
    @chekin = Chekin.find(params[:id])
    if @chekin.update(chekin_params)
      @event = Event.new(user_id: current_user.id,
                         player_id: @chekin.player_id,
                         what_event: "Изменение отметки",
                         checkin: @chekin.chekin,
                         team_id: @chekin.team_id,
                         reason_id: params[:chekin][:reason_id],
                         game_id: @chekin.game_id,
                         time_event: DateTime.now)
      redirect_to root_path, flash: {notice: "Отметка изменена"}
    else
      redirect_to root_path, flash: {"alert-danger": "Произошла ошибка: " + @chekin.errors.full_messages.join(' ')}
    end
  end

  def failed
    @chekin = Chekin.find(params[:format])
    if @chekin.update(chekin: false, presence: false, comment: "Игрок подвел команду")
      @event = Event.new(user_id: current_user.id,
                         player_id: @chekin.player_id,
                         what_event: "Изменение отметки(неявка игрока)",
                         admin: true,
                         checkin: @chekin.chekin,
                         team_id: @chekin.team_id,
                         game_id: @chekin.game_id,
                         time_event: DateTime.now)
      redirect_back fallback_location: root_path, flash: {notice: "Отметка изменена"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @chekin.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @chekin = Chekin.find(params[:id])
    if @chekin.destroy
      redirect_to root_path, flash: {notice: "Отметка удалена"}
    else
      redirect_to root_path, flash: {"alert-danger": "Произошла ошибка: " + @chekin.errors.full_messages.join(' ')}
    end
  end

  private

  def chekin_params
    params.require(:chekin).permit(:player_id, :team_id, :game_id, :chekin, :reason_id, :presence, :comment)
  end

end
