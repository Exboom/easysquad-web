module ApplicationHelper

  def profile_name(user)
    if (Player.find_by_id (user.id)).nil?
      return user.email
    else
      return Player.find(user.id).name
    end
  end

  def welcome_name(user)
    if (Player.find_by_id (user.id)).nil?
      return user.email
    else
      return Player.find(user.id).name.split(' ')[0]
    end
  end

  def users_view(role)
    if (role.find_by role: 1).present?
      return content_tag(:li,
                         content_tag(:a,
                                     content_tag(:i, "", class: "fa fa-users") + " Пользователи",
                                     href: "/admin/users"
                         )
      )
    end
  end

  def pagination(page, object)
    if object.present?
      return render partial: "layouts/pagination", locals: {page: page}
    end
  end

  protected

  def check_admin()
    redirect_to root_path, alert: "У Вас нет прав доступа для данных действий" unless (@userrols.find_by role: 1).present?
  end

  def check_input
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
