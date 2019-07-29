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

  def users_view
    if can? :manege, :all
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

  def check_input
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
