class PlayersController < ApplicationController

  def new
    @player=Player.new
    @user=User.find(current_user.id)
  end

  def edit
    @player=Player.find(params[:id])
  end

  def create
    @user=User.find(params[:player][:id])
    @player=Player.new(player_params)
    @plrteams=params[:player][:team_ids]
    if @player.save
      @plrteams.each do |team|
        if team.nil? or team==""
          next
        else
          UserRole.new(user_id:@user.id,role_id: 4,team_id:team).save
          PlayerTeam.new(player_id:@player.id, team_id:team).save
        end
      end
    end
    redirect_to @player, alert: "Игровой профиль создан"
  end

  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      redirect_to @player
    else
      render 'show'
    end
  end

  def show

    if Player.find_by_id(params[:id]).nil?
      redirect_to welcome_notplayer_path(current_user)
    else
      @player = Player.find(params[:id])
      @teams = @player.teams
      @applications = @player.applications
      if (@userrols.find_by role: 2)!=nil
        @teams=(@teams+@user.teams).uniq
      end
    end

  end

  def destroy
    session[:return_to] ||= request.referer
    @player = Player.find(params[:id])
    if @player.destroy
      UserRole.where(user_id:@player.id, role_id: 4).destroy_all
      @player.player_teams.destroy_all
      @player.chekins.destroy_all
      @player.applications.destroy_all
      redirect_to welcome_index_path, alert: "Игровой профиль успешно удален"
    else
      redirect_to session.delete(:return_to), alert: "Произошла ошибка"
      @player.errors.full_messages.each do |msg|
        puts msg
      end
    end
  end

  private
  def player_params
    params.require(:player).permit(:name, :birthday, :gamenumber, :id)
  end

end
