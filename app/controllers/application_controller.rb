class ApplicationController < ActionController::Base

  before_action :initialize_support
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_back fallback_location: root_path, flash: {"alert-danger": "Ошибка: " + exception.message}
  end

  def initialize_support
    if user_signed_in?
      @userrols = current_user.user_roles
    end
  end

  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

end
