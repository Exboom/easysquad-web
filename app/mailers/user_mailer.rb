class UserMailer < ApplicationMailer

  default template_path: "mailers/user"

  def new_player
    @user = params[:user]
    @team = params[:team]
    @player = params[:player]
    mail(from: 'apo@aiweapps.com', to: @user.email, subject: 'Регистрация игрока')
  end

  def new_team
    @user = params[:user]
    @team = params[:team]
    mail(from: 'apo@aiweapps.com', to: @user.email, subject: 'Регистрация команды')
  end

end
