class UserRolesController < ApplicationController

  def create
    session[:return_to] ||= request.referer
    @userrole=UserRole.new(userrole_params)
    if @userrole.save
      # redirect_to root_path
      redirect_to session.delete(:return_to)
    else
      redirect_to session.delete(:return_to), flash: {"alert-danger": "Произошла ошибка: "+ @userrole.errors.full_messages.join(' ')}
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @userrole = UserRole.find(params[:id])
    @userrole.destroy
    redirect_to session.delete(:return_to)
  end

  private
  def userrole_params
    params.require(:user_role).permit(:user_id, :role_id, :team_id)
  end
  
end
