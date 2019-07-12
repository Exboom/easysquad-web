module ApplicationHelper

  def profile_name(user)
    if (Player.find_by_id (user.id)).nil?
      user.email
    else
      Player.find(user.id).name
    end
  end

  def welcome_name(user)
    if (Player.find_by_id (user.id)).nil?
      user.email
    else
      Player.find(user.id).name.split(' ')[0]
    end
  end

  protected

  def check_admin()
    redirect_to root_path, alert: "У Вас нет прав доступа для данных действий" unless ((@userrols.find_by role: 1) != nil)
  end
end
