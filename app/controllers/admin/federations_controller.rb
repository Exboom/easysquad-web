class Admin::FederationsController < ApplicationController
  before_action :check_admin

  def new
    @federation=Federation.new
  end

  def edit
    @federation=Federation.find(params[:id])
  end

  def create
    @federation=Federation.new(federation_params)
    @federation.save
    redirect_to @federation
  end

  def update
    @federation = Federation.find(params[:id])

    if @federation.update(federation_params)
      redirect_to @federation
    else
      render 'show'
    end
  end

  # def show
  #   tournkey= Tournament.where("federation = ?", params[:id]).pluck(:id)
  #
  #   if tournkey.empty?
  #     @f=nil
  #     @tournaments = "Эта федерация не проводит турниров"
  #   else
  #     @f=1
  #     @tournaments= Tournament.find(tournkey)
  #   end
  #
  #   @federation = Federation.find(params[:id])
  # end

  def destroy
    @federation = Federation.find(params[:id])
    @federation.destroy

    redirect_to welcome_index_path
  end

  private
  def federation_params
    params.require(:federation).permit(:name, :url, :contacts)
  end

  protected

  def check_admin

    @user=User.find(current_user.id)
    @userrols=@user.roles
    redirect_to federation_path, alert:  "У Вас нет прав доступа для данных действий" unless @userrols.first.id==1
  end

end
