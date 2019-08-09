class UserRolesController < ApplicationController

  def create
    @userrole = UserRole.new(userrole_params)
    if @userrole.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @userrole.errors.full_messages.join(' ')}
    end
  end

  def destroy
    @userrole = UserRole.find(params[:id])
    if params[:team_id].present?
      if @userrole.destroy
        @team = Team.find(params[:team_id])
        @owner = @team.user
        @teamadmins = @team.user_roles.where(role_id: 3)
        @cnd = @team.user_roles.where.not(role_id: 3).where.not(user_id: @owner)
        @candidates = Array.new(@cnd.size)
        @cnd.each_with_index do |cnd, index|
          if @teamadmins[0].nil?
            @candidates[index] = Player.find(cnd.user_id)
          else
            if @teamadmins.where(user_id: cnd.user_id).empty?
              @candidates[index] = Player.find(cnd.user_id)
            else
              next
            end
          end
        end
        @candidates = @candidates.reject {|item| item.nil?}
        respond_to do |format|
          format.js
        end
      else
        redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @userrole.errors.full_messages.join(' ')}
      end
    else
      if @userrole.destroy
        redirect_back fallback_location: root_path
      else
        redirect_back fallback_location: root_path, flash: {"alert-danger": "Произошла ошибка: " + @userrole.errors.full_messages.join(' ')}
      end
    end
  end

  private

  def userrole_params
    params.require(:user_role).permit(:user_id, :role_id, :team_id)
  end

end
