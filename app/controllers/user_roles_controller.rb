class UserRolesController < ApplicationController

  def create
    @userrole = UserRole.new(userrole_params)
    if @userrole.save
      # redirect_to root_path
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @userrole.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @userrole = UserRole.find(params[:id])
    @userrole.destroy
    redirect_back fallback_location: root_path
  end

  private

  def userrole_params
    params.require(:user_role).permit(:user_id, :role_id, :team_id)
  end

end
