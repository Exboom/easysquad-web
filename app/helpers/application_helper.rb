module ApplicationHelper
  protected

  def check_admin()
    redirect_to root_path, alert: "У Вас нет прав доступа для данных действий" unless ((@userrols.find_by role: 1) != nil)
  end
end
