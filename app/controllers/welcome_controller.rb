class WelcomeController < ApplicationController
  before_action :check_input

  def index
    if (@userrols.first.id!=1)
      if @userrols.find_by_id(4)!=nil
        @player = Player.find(current_user.id)
        @teampl=@player.teams
        @nextgames=Array.new(@teampl.size)
        @lastgames=Array.new(@teampl.size)
        @teampl.each_with_index do |teampl, index|
          @nextgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NULL", teampl, teampl)
          @lastgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NOT NULL", teampl, teampl)
        end
      elsif (@userrols.find_by_id(2)!=nil) or (@userrols.find_by_id(3)!=nil)
        @teamusr=@user.teams
        @nextgames=Array.new(@teamusr.size)
        @lastgames=Array.new(@teamusr.size)
        @teamusr.each_with_index do |teampl, index|
          @nextgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NULL", teampl, teampl)
          @lastgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NOT NULL", teampl, teampl)
        end
      end
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
