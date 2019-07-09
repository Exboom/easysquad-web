class GamesController < ApplicationController

  def create
    session[:return_to] ||= request.referer
    @game=Game.new(game_params)
    if @game.save
      redirect_to session.delete(:return_to), flash: {notice: "Игра успешно добавлена"}
    else
      redirect_to session.delete(:return_to), flash: {"alert-danger": "Произошла ошибка: "+ @game.errors.full_messages.join(' ')}
    end
  end

  def update
    session[:return_to] ||= request.referer
    @game = Game.find(params[:id])
    if @game.update(game_params)
      @event=Event.new(user_id: current_user.id,
                       what_event: "Установлен счет",
                       game_id: @game.id,
                       player_id: current_user.id,
                       team_id: params[:game][:team_id],
                       score: @game.game_score,
                       time_event: DateTime.now)
      redirect_to session.delete(:return_to), flash: {notice: "Счет установлен"}
    else
      redirect_to session.delete(:return_to), flash: {"alert-danger": "Произошла ошибка: "+ @game.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to welcome_index_path
  end

  private
  def game_params
    params.require(:game).permit(:team_one, :team_two, :name, :time, :tournament_id, :location_id, :game_score)
  end

end
