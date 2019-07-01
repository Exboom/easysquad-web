class WelcomeController < ApplicationController
  before_action :check_input

  def index
    if (@userrols.find_by role: 1).nil?
      if (@userrols.find_by role: 4)!=nil
        @player = Player.find(current_user.id)
        @teampl=@player.teams
        @teamusrng=@teampl
        @nextgames=Array.new(@teampl.size)
        @lastgames=Array.new(@teampl.size)
        @alltournteams=Team.all #all teams in tourn
        @teampl.each_with_index do |teampl, index|
          @nextgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NULL", teampl, teampl)
          @lastgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NOT NULL", teampl, teampl)
        end
      elsif ((@userrols.find_by role: 2)!=nil) or ((@userrols.find_by role: 3)!=nil)
        @teamusr=@user.teams
        @teamusrng=@teamusr
        @nextgames=Array.new(@teamusr.size)
        @lastgames=Array.new(@teamusr.size)
        @alltournteams=Team.all #all teams in tourn
        @teamusr.each_with_index do |teampl, index|
          @nextgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NULL", teampl, teampl)
          @lastgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NOT NULL", teampl, teampl)
        end
      end
    end
  end

  def update_teams
    @tourn=Tournament.find(params[:tournament_id])
    @alltournteams=@tourn.teams
    if (@userrols.find_by role: 2)!=nil
      @teamusrng=@tourn.teams.where(user_id: current_user.id)
      if @teamusrng.size==1
        @alltournteams=@tourn.teams.where.not(id: @teamusrng[0])
      end
    elsif (@userrols.find_by role: 3)!=nil
      @player = Player.find(current_user.id)
      @teamusrng = UserRole.where(user_id: current_user.id, role_id: 3).pluck(:team_id)
      @teamusrng=@tourn.teams.where(id: @teamusrng)
      if @teamusrng.size==1
        @alltournteams=@tourn.teams.where.not(id: @teamusrng[0])
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def update_enemy
    @tourn=Tournament.find(params[:tournament_id])
    @alltournteams=@tourn.teams.where.not(id: params[:myteam_id])
  end

  def notplayer
    @teamsusr=@user.teams
    @rols=@user.roles
  end

  protected

  def check_input
    unless user_signed_in?
      redirect_to new_user_session_path
    end

  end

end
