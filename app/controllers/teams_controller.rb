class TeamsController < ApplicationController
  include ApplicationHelper
  before_action :check_input

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

  def myteams
    if Player.find_by_id(current_user.id).nil?
      @teams = current_user.teams
    else
      @player = Player.find(current_user.id)
      @teams = (@player.teams + current_user.teams).uniq
    end
  end

  def edit
    @team = Team.find(params[:id])
    authorize! :edit, @team
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to @team, flash: {notice: "Информация о команде изменена"}
    else
      redirect_back fallback_location: @team, flash: {"alert-danger": "Произошла ошибка: " + @team.errors.full_messages.join(' ')}
    end
  end

  def show
    @team = Team.find(params[:id])
    @owner = @team.user
    @cap = @team.player
    @teamadmins = @team.user_roles.where(role_id: 3)
    @cnd = @team.user_roles.where.not(role_id: 3).where.not(user_id: @owner)
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
    authorize! :edit, @team
    @allplayers = @team.players
    @players = Array.new(@allplayers.size)
    @tournplr = Array.new(@allplayers.size)
    @allplayers.each_with_index do |plr, index|
      if plr.rosters.where(tournament_id: @tourn.id).empty?
        @players[index] = plr
      else
        next
      end
    end
    @allplayers.each_with_index do |plr, index|
      if plr.rosters.where(tournament_id: @tourn.id, team_id: @team.id).empty?
        next
      else
        @tournplr[index] = plr
      end
    end
    @tournplr.reject! {|item| item.nil?}
    @players.reject! {|item| item.nil?}
  end

  private

  def team_params
    params.require(:team).permit(:name, :user_id, :player_id)
  end

end
