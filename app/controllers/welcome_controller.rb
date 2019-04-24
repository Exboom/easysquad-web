class WelcomeController < ApplicationController
  def index
    @games = Game.first(5)
  end

  def notplayer
    @user = current_user.email
  end
end
