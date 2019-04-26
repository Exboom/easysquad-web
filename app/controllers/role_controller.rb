class RoleController < ApplicationController

  def show
    @role = Role.find([:id])
  end

end
