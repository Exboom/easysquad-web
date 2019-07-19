class TeamsController < ApplicationController
  include ApplicationHelper
  before_action :check_input
  before_action :check_owner, only: [:edit]

  def index
    @teams_page = (Team.all.size / 13.0).ceil
    if params[:offset].nil?
      @teams = Team.limit(13).offset(0)
    else
      @teams = Team.limit(13).offset(params[:offset].to_i * 13)
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_back fallback_location: @team, flash: {notice: "Информация о команде изменена"}
    else
      redirect_back fallback_location: @team, flash: {"alert-danger": "Произошла ошибка: " + @team.errors.full_messages.join(' ')}
    end
  end

  def show
    @team = Team.find(params[:id])
    @owner = @team.user
    @cap = @team.player
    @teamadmins = @team.user_roles.where(role_id: 3)
    @cnd = @team.user_roles.where.not(role_id: 3).where.not(role_id: 2)
    @candidates = Array.new(@cnd.size)
    @cnd.each_with_index do |cnd, index|
      if @teamadmins[0].nil?
        @candidates[index] = Player.find(cnd.user_id)
      else
        if @teamadmins.where(user_id: cnd.user_id).empty?
          @candidates[index] = Player.find(cnd.user_id)
        else
          next
        end
      end
    end
    @candidates = @candidates.reject {|item| item.nil?}
  end

  def appfortourn
    @tourn = Tournament.find(params[:tourn])
    @team = Team.find(params[:team])
    @allplayers = @team.players
    @players = Array.new(@allplayers.size)
    @allplayers.each_with_index do |plr, index|
      if plr.rosters.where(tournament_id: @tourn.id).empty?
        @players[index] = plr
      else
        next
      end
    end
    @players.reject! {|item| item.nil?}
  end

  def creat_appfortourn
    @team = Team.find(params[:game][:team_id])
    @plrapp = params[:game][:player_id]
    @plrapp.each do |app|
      if app.nil? or app == ""
        next
      else
        @newapp = Roster.new(player_id: app, team_id: @team.id, tournament_id: params[:game][:tourn_id])
        if @newapp.save
        else
          redirect_back fallback_location: @team, flash: {"alert-danger": "Произошла ошибка: " + @newapp.errors.full_messages.join(' ')}
        end
      end
    end
    redirect_to @team, flash: {notice: "Заявка создана"}
  end

  private

  def team_params
    params.require(:team).permit(:name, :user_id, :player_id)
  end

  def check_owner
    @team = Team.find(params[:id])
    redirect_to @team,
                alert: "У Вас нет прав доступа для данных действий" unless (current_user.id == @team.user_id) or (@userrols.find_by role: 3, team: @team.id).present?
  end

end
