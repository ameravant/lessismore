class LocationsController < ApplicationController
  add_breadcrumb "Home", "/"

  def index
    add_breadcrumb "Locations"
    @locations = Location.all
    @page = Page.find_by_permalink("locations")
  end

  def show
    add_breadcrumb "Locations", locations_path
    @location = Location.find params[:id]
    @materials = @location.materials.find :all, :include => :material_category
    @page = Page.find_by_permalink("locations")
    add_breadcrumb @location.name
  end

end

