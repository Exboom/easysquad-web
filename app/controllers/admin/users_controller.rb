class Admin::UsersController < ApplicationController
  before_action :check_admin

  def new
    @user = User.new
  end

  def edit
    @user=User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to root_path, alert:  "Пользователь зарегестрирован"
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
