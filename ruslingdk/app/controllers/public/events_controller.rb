class Public::EventsController < PublicApplicationController
  def show
    @event = @domain.events.find(params[:id])
  end

  def index
    @events = @domain.events
  end
end
