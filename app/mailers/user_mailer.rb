class UserMailer < ApplicationMailer

  default template_path: "mailers/user"

  def new_player
    mail(from: 'dr.modi@yndex.ru', to: 'apo@aiweapps.com', subject: ' Регистрация на ресурсе')
  end

  def new_team

  end

end
