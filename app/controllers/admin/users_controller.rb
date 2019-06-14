class Admin::UsersController < ApplicationController
  before_action :check_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to root_path, alert:  "Пользователь зарегестрирован"
  end

  protected

  def check_admin
    @user=User.find(current_user.id)
    @userrols=@user.roles
    redirect_to root_path, alert:  "У Вас нет прав доступа для данных действий" unless @userrols.first.id==1
  end

  def user_params
    params.require(:user).permit(
        :name, :email, :password, :password_confirmation
    )
  end

end
