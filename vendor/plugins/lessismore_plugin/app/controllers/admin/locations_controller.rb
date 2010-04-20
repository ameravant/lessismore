class Admin::LocationsController < AdminController
unloadable
  before_filter :find_location, :except => [ :index, :new, :create ]
  before_filter :find_materials
  before_filter :find_regions, :except => [:index]
  before_filter :add_crumbs, :except => :index

  def index
    add_breadcrumb "Locations"
    @locations = Location.by_name
  end

  def new
    add_breadcrumb "New"
    @location = Location.new
  end

  def create
    @location = Location.new params[:location]
    if @location.save
      flash[:notice] = "#{@location.name} created."
      redirect_to admin_locations_path
    else
      render :action => "new"
    end
  end

  def edit
    add_breadcrumb "Edit"
  end

  def update
    if @location.update_attributes params[:location]
      flash[:notice] = "#{@location.name} updated."
      redirect_to admin_locations_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    respond_to do |wants|
      wants.html { redirect_to admin_events_path }
      wants.js
    end
  end


  private

  def add_crumbs
    add_breadcrumb "Locations", admin_locations_path
  end

  def find_location
    @location = Location.find params[:id], :include => :materials
  end

  def find_regions
    @regions = Region.find(:all, :order => "name")
  end

  def find_materials
    @materials = Material.find :all, :include => :material_category
  end

end

