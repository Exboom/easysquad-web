class Admin::TeamsController < ApplicationController
  before_action :check_admin

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
    @users = User.all
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      UserRole.new(user_id: @team.user.id, role_id: 2, team_id: @team.id).save!
      User.find(@team.user.id).update(approved: true)
      redirect_to @team, flash: {notice: "Команда успешно создана"}
    else
      redirect_to root_path, flash: {"alert-danger": "Произошла ошибка: " + @team.errors.full_messages.join(' ')}
    end
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to @team, flash: {notice: "Команда успешно обновлена"}
    else
      redirect_to @team, flash: {"alert-danger": "Произошла ошибка: " + @team.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @team = Team.find(params[:id])
    Game.where(team_one: @team) or (Game.where(team_two: @team)).destroy_all
    if @team.destroy
      redirect_to root_path, flash: {notice: "Команда успешно удалена"}
    else
      redirect_to @team, flash: {"alert-danger": "Произошла ошибка: " + @team.errors.full_messages.join(' ')}
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :user_id, :player_id, :default_password)
  end

  protected

  def check_admin
    redirect_to team_path, alert: "У Вас нет прав доступа для данных действий" unless ((@userrols.find_by role: 1) != nil)
  end

end
