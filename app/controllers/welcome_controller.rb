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

        # @teamrole=@user.user_roles
        @teamusr=@user.teams
        @nextgames=Array.new(@teamusr.size)
        @lastgames=Array.new(@teamusr.size)
        @teamusr.each_with_index do |teampl, index|
          @nextgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NULL", teampl, teampl)
          @lastgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NOT NULL", teampl, teampl)
        end



        puts "это размер игр = "+@nextgames.size.to_s

        @nextgames.each_with_index do |nxt, index|
          # puts "Вывод значения индекса = "+index.to_s
          nxt.each do |nxtgm|
            puts "Вывод значения индекса = "+index.to_s
            # puts "Вывод имени,ID = "+@teamusr[index].name+" "+(nxtgm.id.to_i).to_s
            puts "Вывод имени,ID+индекс = "+@teamusr[index].name+" "+(nxtgm.id.to_i+index.to_i*2).to_s
            # puts "Вывод значения ID  игры + индекс = "+nxtgm.id.to_i
          end
        end



      # elsif @userrols.find_by_id(3)!=nil
      #
      #   @teamrole=@user.user_roles

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
