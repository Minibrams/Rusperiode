class Public::EventsController < PublicApplicationController
  def show
    @event = @domain.events.find(params[:id])
  end
end
