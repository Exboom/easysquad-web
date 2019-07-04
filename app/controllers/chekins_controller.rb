class ChekinsController < ApplicationController

  def new
    @player=Player.find(current_user.id)
    @chekin=Chekin.new
    @game=Game.find(params[:format])
    @lastchekin=Chekin.find_by player:@player, game: @game
  end

  def edit
    @chekin=Chekin.find(params[:id])
    @player=@chekin.player
    @game=@chekin.game
    @team=@chekin.team
  end

  def create
    session[:return_to] ||= request.referer
    @chekin=Chekin.new(chekin_params)
    if @chekin.save
      @event=Event.new(user_id: current_user.id,
                       player_id: @chekin.player_id,
                       what_event: "Отметка на игру",
                       checkin: @chekin.chekin,
                       admin: params[:chekin][:admin],
                       reason_id: params[:chekin][:reason_id],
                       team_id: @chekin.team_id,
                       game_id: @chekin.game_id,
                       time_event: DateTime.now)
      if !@event.save
        @event.errors.full_messages.each do |msg|
          puts msg
        end
      end
      redirect_to session.delete(:return_to), alert: "Отметка произведена успешно"
    else
      redirect_to session.delete(:return_to), alert: "Произошла ошибка!"
      @chekin.errors.full_messages.each do |msg|
        msg
      end
    end
  end

  def update
    @chekin = Chekin.find(params[:id])
    if @chekin.update(chekin_params)
      @event=Event.new(user_id: current_user.id,
                       player_id: @chekin.player_id,
                       what_event: "Изменение отметки",
                       checkin: @chekin.chekin,
                       team_id: @chekin.team_id,
                       reason_id: params[:chekin][:reason_id],
                       game_id: @chekin.game_id,
                       time_event: DateTime.now)
      if !@event.save
        @event.errors.full_messages.each do |msg|
          puts msg
        end
      end
      redirect_to root_path, alert: "Отметка изменена"
    else
      redirect_to root_path, alert: "Произошла ошибка!"
      @chekin.errors.full_messages.each do |msg|
        msg
      end
    end
  end

  def failed
    session[:return_to] ||= request.referer
    @chekin = Chekin.find(params[:format])
    if @chekin.update(chekin: false, presence: false, comment: "Игрок подвел команду")
      @event=Event.new(user_id: current_user.id,
                       player_id: @chekin.player_id,
                       what_event: "Изменение отметки(неявка игрока)",
                       admin: true,
                       checkin: @chekin.chekin,
                       team_id: @chekin.team_id,
                       game_id: @chekin.game_id,
                       time_event: DateTime.now)
      if !@event.save
        @event.errors.full_messages.each do |msg|
          puts msg
        end
      end
      redirect_to session.delete(:return_to), alert: "Отметка изменена"
    else
      redirect_to session.delete(:return_to), alert: "Произошла ошибка"
      @chekin.errors.full_messages.each do |msg|
        puts msg
      end
    end
  end

  def show
    @chekin = Chekin.find(params[:id])
    @player=@chekin.player
    @game=@chekin.game
    @team=@chekin.team
    @reason=@chekin.reason
  end

  def destroy
    @chekin = Chekin.find(params[:id])
    @chekin.destroy

    redirect_to welcome_index_path
  end

  private
  def chekin_params
    params.require(:chekin).permit(:player_id, :team_id, :game_id, :chekin, :reason_id, :presence, :comment)
  end
  
end
