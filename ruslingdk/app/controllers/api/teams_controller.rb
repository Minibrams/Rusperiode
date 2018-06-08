module Api
  class TeamsController < ApplicationController
    before_filter :find_team

    def index; end

    def show; end

    def update; end

    def destroy; end

  private

    def find_team
      @match = CsGo::Team.find(params[:id]) if params[:id]
    end
  end
end
