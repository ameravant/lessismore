class LocationsController < ApplicationController
  unloadable
  add_breadcrumb "Home", "/"

  def index
    add_breadcrumb "Locations"
    @locations = Location.all
    @page = Page.find_by_permalink("locations")
    @sub_pages = Page.find(:all, :conditions => {:parent_id => @page.parent_id, :status => 'visible', :can_delete => true })
  end

  def show
    add_breadcrumb "Locations", locations_path
    @location = Location.find params[:id]
    @materials = @location.materials.find :all, :include => :material_category
    @page = Page.find_by_permalink("locations")
    @sub_pages = Page.find(:all, :conditions => {:parent_id => @page.parent_id, :status => 'visible', :can_delete => true })
    add_breadcrumb @location.name
  end

end

