class RostersController < ApplicationController

  def create
    @team = Team.find(params[:team_id])
    @tourn = Tournament.find(params[:tournament_id])
    @application = Roster.new(player_id: params[:player_id], team_id: @team.id, tournament_id: @tourn.id)
    if @application.save
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
        if plr.rosters.where(tournament_id: @tourn.id).empty?
          next
        else
          @tournplr[index] = plr
        end
      end
      @tournplr.reject! {|item| item.nil?}
      @players.reject! {|item| item.nil?}
      respond_to do |format|
        format.js
      end
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @application.errors.full_messages.join(' ')}
    end
  end

  def update
    @application = Roster.find(params[:id])
    if @application.update(application_params)
      redirect_to @application
    else
      render 'show'
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @tourn = Tournament.find(params[:tourn_id])
    @application = Roster.find_by(player_id: params[:id], team_id: @team, tournament_id: @tourn)
    if @application.destroy
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
      respond_to do |format|
        format.js
      end
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @application.errors.full_messages.join(' ')}
    end
  end

  private

  def application_params
    params.require(:application).permit(:player_id, :team_id, :tournament_id)
  end

end
