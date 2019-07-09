class UsersController < ApplicationController
  before_action :check_admin

  def new
    @user = User.new
  end

  def edit
    @user=User.find(params[:id])
  end

  def create
    session[:return_to] ||= request.referer
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @team=Team.find(params[:user][:team_id])
    @user = User.new(email: params[:user][:email],password: @team.default_password, password_confirmation: @team.default_password)
    if @user.save
      @user.update(approved: params[:user][:approved])
      UserRole.new(user_id: @user.id, role_id: 4, team_id: params[:user][:team_id]).save
      Player.new(id: @user.id, name: params[:user][:name]).save
      PlayerTeam.new(player_id: @user.id, team_id: params[:user][:team_id]).save

      # @mail=UserMailer.new_player #mail in my email for test
      # if @mail.deliver_now
      #   puts "Все хорошо"
      # else
      #   @mail.errors.full_messages.each do |msg|
      #     puts msg
      #   end
      # end

      redirect_to session.delete(:return_to), flash: {notice: "Пользователь зарегестрирован"}
    else
      redirect_to session.delete(:return_to), flash: {"alert-danger": "Произошла ошибка: "+ @user.errors.full_messages.join(' ')}
    end
  end

  def update
    session[:return_to] ||= request.referer
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
      redirect_to session.delete(:return_to), flash: {notice: "Информация обновлена"}
    else
      redirect_to session.delete(:return_to), flash: {"alert-danger": "Произошла ошибка: "+ @user.errors.full_messages.join(' ')}
    end
  end

  protected

  def check_admin
    @team = Team.find(params[:user][:team_id])
    redirect_to team_path,
                alert:  "У Вас нет прав доступа для данных действий" unless (current_user.id==@team.user_id) or !UserRole.where(user_id:current_user, role_id:3, team_id:@team).nil?
  end

  def user_params
    params.require(:user).permit(
        :email, :password, :password_confirmation, :approved
    )
  end

end
