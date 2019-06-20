class WelcomeController < ApplicationController
  before_action :check_input

  def index

    if (@userrols.first.id!=1)

      if @userrols.find_by_id(4)!=nil
        @player = Player.find(current_user.id)
        @teampl=@player.teams
        @nextgames=Array.new(@teampl.size)
        @teampl.each_with_index do |teampl, index|
          @nextgames[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NULL", teampl, teampl)
        end

        if @nextgames.to_s=="[nil]"
          puts "она ноль"
        else
            puts "вывод числа элементов nextgames "+@nextgames.size.to_s
            puts "Это вывод @nextgames 1 "+@nextgames[0].to_s
            puts "Это вывод @nextgames 2 "+@nextgames[1].to_s



            @nextgames.each do |nxt|
              nxt.each do |nxtg|
                puts nxtg.name
                appl=Application.find_by player:@player, tournament: nxtg.tournament
                puts "Это номер заявки "+appl.id.to_s
                chek= Chekin.find_by player:@player, game: nxtg
                if chek.nil?
                  puts "Такого чекина нет"
                else
                  puts "Это номер чекина "+chek.id.to_s
                end

              end
            end


            # @app=Array.new(@nextgames.size)
            # @lastchekin=Array.new(@nextgames.size)
            #
            # @nextgames.each_with_index do |nxtgmmas, index1|
            #   nxtgmmas[index1].each_with_index do |nxtgm, index2|
            #     @app[index2]=Application.find_by player:current_user.id, tournament: nxtgm.tournament
            #     @lastchekin[index2]=Chekin.find_by player:@player, game: @nextgame[index2]
            #   end
            # end
            #
            #
            # @nextgame.each_with_index do |nxtgm, index|
            #   @app[index]=Application.find_by player:current_user.id, tournament: nxtgm.tournament
            #   @lastchekin[index]=Chekin.find_by player:@player, game: @nextgame[index]
            # end


        end

      elsif @userrols.find_by_id(2)!=nil

        @teamrole=@user.user_roles

      elsif @userrols.find_by_id(3)!=nil

        @teamrole=@user.user_roles

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
