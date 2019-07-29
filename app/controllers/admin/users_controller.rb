class Admin::UsersController < ApplicationController

  load_and_authorize_resource

  def index
    @users_page = (User.all.size / 13.0).ceil
    if params[:offset].nil?
      @users = User.limit(13).offset(0)
    else
      @users = User.limit(13).offset(params[:offset].to_i * 13)
      respond_to do |format|
        format.js
      end
    end
  end

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
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @user.errors.full_messages.join(' ')}
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

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      if Player.find_by(id: @user.id).present?
        Player.find(@user.id).destroy
      end
      redirect_back fallback_location: root_path, flash: {notice: "Пользователь удален"}
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @user.errors.full_messages.join(' ')}
    end
  end

  protected

  def user_params
    params.require(:user).permit(
        :name, :email, :password, :password_confirmation, :approved
    )
  end

end
