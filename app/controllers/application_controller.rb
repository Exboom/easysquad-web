class ApplicationController < ActionController::Base

  before_action :initialize_support
  layout :layout_by_resource

  def initialize_support
    #команды
    @allteams=Team.all
    #федерации
    @federations=Federation.all
    #локации
    @locs=Location.all
    #турниры
    @tourns=Tournament.all
    #new for all controllers
    if current_user!=nil
      @user=User.find(current_user.id)
      @userrols=@user.roles
      @usersNew = User.where("approved = ?", false)
    end
  end

  def adm_new_up
    @user=User.find(current_user.id)
    @userrols=@user.roles
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
