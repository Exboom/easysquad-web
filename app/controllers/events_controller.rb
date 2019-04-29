class EventsController < ApplicationController

  def new
    @event=Event.new
  end

  def edit
    @event=Event.find(params[:id])
  end

  def create
    @event=Event.new(event_params)
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render 'show'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to welcome_index_path
  end

  private
  def event_params
    params.require(:event).permit(:whose_event, :what_event, :time_event)
  end

end
