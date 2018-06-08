module Api
  class MatchesController < ApplicationController
    before_filter :find_match

    def index; end

    def show; end

    def update; end

    def destroy; end

  private

    def find_match
      @match = CsGo::Match.find(params[:id]) if params[:id]
    end
  end
end
