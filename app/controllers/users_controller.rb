class UsersController < ApplicationController
  # before_action :check_admin

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
    @user = User.new(user_params)
    if @user.save
      redirect_to session.delete(:return_to), alert:  "Пользователь зарегестрирован"
    else
      render 'show'
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
      redirect_to session.delete(:return_to)
    else
      render 'show'
    end
  end

  protected

  def check_admin
    @team = Team.find(params[:id])
    redirect_to team_path,
                alert:  "У Вас нет прав доступа для данных действий" unless (current_user.id==@team.user_id) or !(@userrols.find_by_id(1).nil?)



    @user=User.find(current_user.id)
    @userrols=@user.roles
    redirect_to root_path, alert:  "У Вас нет прав доступа для данных действий" unless @userrols.first.id==1
  end

  def user_params
    params.require(:user).permit(
        :name, :email, :password, :password_confirmation, :approved
    )
  end

end
