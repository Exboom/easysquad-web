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
    param=UserRole.find_by user1: current_user.id
    @userrols = Role.find(param.role1)
    redirect_to root_path, alert:  "У Вас нет прав доступа для данных действий" unless @userrols.id==1
  end

  def user_params
    params.require(:user).permit(
        :name, :email, :password, :password_confirmation
    )
  end

end
