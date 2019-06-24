class UserRolesController < ApplicationController

  def new
    @user=User.find(params[:format])
    @userrole=UserRole.new
  end

  def edit
    @userrole=UserRole.find(params[:id])
  end

  def create
    @userrole=UserRole.new(userrole_params)
    if @userrole.save
      redirect_to root_path
    else
      render 'new'
    end

  end

  def update
    @userrole = UserRole.find(params[:id])

    if @userrole.update(userrole_params)
      redirect_to @userrole
    else
      render 'show'
    end
  end

  def show
    @user=User.find(params[:id])
    @userrols=@user.roles
    @teams=@user.teams
  end

  def destroy
    @userrole = UserRole.find(params[:id])
    @userrole.destroy

    redirect_to welcome_index_path
  end

  private
  def userrole_params
    params.require(:user_role).permit(:user_id, :role_id, :team_id)
  end
  
end
