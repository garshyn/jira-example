class JourneyMapsController < ApplicationController
  def index
    @journey_maps = JourneyMap.all
  end

  def show
    # sleep 1
    @journey_map = JourneyMap.find params[:id]
  end
end
