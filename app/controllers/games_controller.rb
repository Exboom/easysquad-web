class GamesController < ApplicationController

  def new
    @game=Game.new
  end

  def edit
    @game=Game.find(params[:id])
  end

  def create
    session[:return_to] ||= request.referer
    @game=Game.new(game_params)
    if @game.save
      redirect_to session.delete(:return_to), alert: "Игра успешно добавлена"
    else
      redirect_to session.delete(:return_to), alert: "Произошла ошибка при добавлении игры"
      @game.errors.full_messages.each do |msg|
        puts msg
      end
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
      if !@event.save
        @event.errors.full_messages.each do |msg|
          puts msg
        end
      end
      redirect_to session.delete(:return_to), alert: "Счет установлен"
    else
      redirect_to session.delete(:return_to), alert: "Произошла ошибка"
      @game.errors.full_messages.each do |msg|
        puts msg
      end
    end
  end

  def show
    @game = Game.find(params[:id])
    @app=Application.find_by player:current_user.id, tournament: @game.tournament
    @players=@game.chekins.player
    @team1=Team.find(@game.team_one)
    @team2=Team.find(@game.team_two)
    @tourn=@game.tournament
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
