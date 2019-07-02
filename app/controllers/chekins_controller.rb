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
      Event.new(user_id: current_user.id, what_event: "Отметка о присутствии игрока", time_event: DateTime.now).save
      redirect_to session.delete(:return_to), alert: "Вы успешно отметились на игру"
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
      Event.new(user_id: current_user.id, what_event: "Изменение отметки о присутствии игрока "+@chekin.player.name+" новое значение: "+@chekin.chekin.to_s, time_event: DateTime.now).save
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
      Event.new(user_id: current_user.id, what_event: "Изменение отметки о присутствии, игрок "+@chekin.player.name+" подвел команду", time_event: DateTime.now).save
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
