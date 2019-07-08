class UserMailer < ApplicationMailer

  default from: 'info@easysquad.com',
          template_path: "mailers/user"

  def new_player
    mail to: 'dr.modi@yandex.ru',
         subject: "Чел зарегался"
  end

  def new_team

  end

end
