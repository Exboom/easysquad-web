class PlayersController < ApplicationController
  include ApplicationHelper
  before_action :check_input

  def new
    @player = Player.new
    @user = User.find(current_user.id)
  end

  def edit
    @player = Player.find(params[:id])
    authorize! :edit, @player
  end

  def create
    @player = Player.new(player_params)
    @plrteams = params[:player][:team_ids]
    if @player.save
      @plrteams.each do |team|
        if team.nil? or team == ""
          next
        else
          UserRole.new(user_id: current_user.id, role_id: 4, team_id: team).save
          PlayerTeam.new(player_id: @player.id, team_id: team).save
        end
      end
      redirect_to @player, flash: {notice: "Игровой профиль создан"}
    else
      redirect_to root_path, flash: {"alert-danger": "Произошла ошибка: " + @player.errors.full_messages.join(' ')}
    end
  end

  def update
    @player = Player.find(params[:id])
    authorize! :edit, @player
    if @player.update(player_params)
      redirect_to @player, flash: {notice: "Игровой профиль обновлен"}
    else
      redirect_to @player, flash: {"alert-danger": "Произошла ошибка: " + @player.errors.full_messages.join(' ')}
    end
  end

  def show
    if Player.find_by_id(params[:id]).nil?
      redirect_to welcome_notplayer_path(current_user)
    else
      @user=User.find(params[:id])
      @player = Player.find(params[:id])
      @userrols_plr = User.find(params[:id]).user_roles
      @teams = @player.teams
      @applications = @player.rosters
      if (@userrols_plr.find_by role: 2).present?
        @teams = (@teams + @user.teams).uniq
      end
    end
  end

  def destroy
    @player = Player.find(params[:id])
    authorize! :edit, @player
    if @player.destroy
      UserRole.where(user_id: @player.id, role_id: 4).where(user_id: @player.id, role_id: 3).destroy_all
      redirect_to root_path, flash: {notice: "Игровой профиль удален"}
    else
      redirect_back fallback_location: @player, flash: {"alert-danger": "Произошла ошибка: " + @player.errors.full_messages.join(' ')}
    end
  end

  def destroy_together_user
    @player = Player.find(current_user.id)
    authorize! :edit, @player
    if @player.destroy
      redirect_to root_path, flash: {notice: "Игровой профиль удален"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @player.errors.full_messages.join(' ')}
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :birthday, :gamenumber, :id)
  end

end
