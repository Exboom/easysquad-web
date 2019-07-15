class ApplicationController < ActionController::Base

  before_action :initialize_support
  layout :layout_by_resource

  def initialize_support
    if current_user != nil
      @userrols = current_user.user_roles
      @usersNew = User.where("approved = ?", false)
    end
  end

  def adm_new_up
    @usersNew = User.where("approved = ?", false)
    respond_to do |format|
      format.js
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
