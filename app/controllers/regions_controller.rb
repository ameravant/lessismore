class RegionsController < ApplicationController
  def index
    @regions = Region.all
  end
  def show
    @region = Region.find(params[:id])
    @locations = @region.locations
  end
end