class WelcomeController < ApplicationController
  before_action :check_input

  def index
    if (@userrols.first.id!=1)
      if @userrols.find_by_id(4)!=nil
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
      elsif (@userrols.find_by_id(2)!=nil) or (@userrols.find_by_id(3)!=nil)
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

    if @userrols.find_by_id(2)!=nil
      @teamusrng=@tourn.teams.where(user_id: current_user.id)
    elsif @userrols.find_by_id(3)!=nil
      @player = Player.find(current_user.id)
      @teamusrng=@tourn.teams.find(@player.teams.ids)
    end
    respond_to do |format|
      format.js
    end
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
