class WelcomeController < ApplicationController
  before_action :check_input

  def index
    #игры
    @games=Game.all
    @lastgames = Game.where("game_score is not NULL")
    #команды
    @teams=Team.all
    #федерации
    @federations=Federation.all
    #локации
    @locs=Location.all
    #турниры
    @tourns=Tournament.all
    # @users = User.all
    @usersNew = User.where("approved = ?", false)

    if current_user!=nil
      @user=User.find(current_user.id)
      @userrols=@user.roles
    end

    if (@userrols.first.id!=1)

      if @userrols.find_by_id(4)!=nil
        @player = Player.find(current_user.id)
        @teampl=@player.teams
        @nextgame=Array.new(@teampl.size)
        # @lastchekin=Chekin.find_by player:@player, game: @game
        @teampl.each_with_index do |teampl, index|
          @nextgame[index]=Game.where("(team_one = ? OR team_two = ?) AND game_score is NULL", teampl, teampl).take
        end

        if !@nextgame.empty?
          @app=Array.new(@nextgame.size)
          @lastchekin=Array.new(@nextgame.size)
          @nextgame.each_with_index do |nxtgm, index|
            @app[index]=Application.find_by player:current_user.id, tournament: nxtgm.tournament
            @lastchekin[index]=Chekin.find_by player:@player, game: @nextgame[index]
          end
        end

      elsif @userrols.find_by_id(2)!=nil

        @teamrole=@user.user_roles

      elsif @userrols.find_by_id(3)!=nil

        @teamrole=@user.user_roles

      end

    end

  end

  def notplayer

    @teams=Team.all
    #федерации
    @federations=Federation.all
    #локации
    @locs=Location.all
    #турниры
    @tourns=Tournament.all

    @user = User.find(current_user.id)
    @teamsusr=@user.teams
    @rols=@user.roles


  end

  protected

  def check_input
    unless user_signed_in?
      redirect_to new_user_session_path
    end

    # if user_signed_in?
    #   @user=User.find(current_user.id)
    #   redirect_to new_user_session_path, alert:  "Ваша учетная запись еще не активирована" if @user.approved==false
    # end

  end

  # def check_approved
  #   @user=User.find(current_user.id)
  #   redirect_to new_user_session_path, alert:  "Ваша учетная запись еще не активирована" if @user.approved==false
  # end

end
