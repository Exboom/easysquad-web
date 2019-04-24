class UserRolesController < ApplicationController

  def new
    @userrole=UserRole.new
  end

  def edit
    @userrole=UserRole.find(params[:id])
  end

  def create
    @userrole=UserRole.new(userrole_params)
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
    @userrole = UserRole.find([:id])
  end

  def destroy
    @userrole = UserRole.find(params[:id])
    @userrole.destroy

    redirect_to welcome_index_path
  end

  private
  def userrole_params
    params.require(:userrole).permit(:olayer, :role, :team)
  end
  
end
