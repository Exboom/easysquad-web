class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @team = Team.find(params[:team_id])
    authorize! :edit, @team
    @user = User.new(email: params[:email], password: @team.default_password, password_confirmation: @team.default_password)
    if @user.save
      @user.update(approved: params[:approved])
      UserRole.new(user_id: @user.id, role_id: 4, team_id: params[:team_id]).save
      @player = Player.new(id: @user.id, name: params[:name])
      @player.save
      PlayerTeam.new(player_id: @user.id, team_id: params[:team_id]).save
      # mailer
      @mail = UserMailer.with(user: @user, team: @team, player: @player).new_player
      @mail.deliver_now
      # mailer
      respond_to do |format|
        format.js {flash[:notice] = "Пользователь зарегестрирован"}
      end
    else
      redirect_back fallback_location: @team, flash: {"alert-danger": "Произошла ошибка: " + @user.errors.full_messages.join(' ')}
    end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
      redirect_back fallback_location: root_path, flash: {notice: "Информация обновлена"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @user.errors.full_messages.join(' ')}
    end
  end

  protected

  def user_params
    params.require(:user).permit(
        :email, :password, :password_confirmation, :approved
    )
  end

end
