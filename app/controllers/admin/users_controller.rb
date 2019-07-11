class Admin::UsersController < ApplicationController
  include ApplicationHelper
  before_action :check_admin

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, flash: {notice: "Пользователь зарегестрирован"}
    else
      redirect_to root_path, flash: {"alert-danger": "Произошла ошибка: " + @user.errors.full_messages.join(' ')}
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
      redirect_to session.delete(:return_to), flash: {"alert-danger": "Произошла ошибка: " + @user.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      Player.find(@user.id).destroy
      redirect_to root_path, flash: {notice: "Информация обновлена"}
    else
      redirect_to root_path, flash: {"alert-danger": "Произошла ошибка: " + @user.errors.full_messages.join(' ')}
    end
  end

  protected

  def user_params
    params.require(:user).permit(
        :name, :email, :password, :password_confirmation, :approved
    )
  end

end
