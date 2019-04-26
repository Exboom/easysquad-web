class ReasonController < ApplicationController

  def show
    @reason = Reason.find([:id])
  end

end
