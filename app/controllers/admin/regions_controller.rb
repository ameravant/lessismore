class Admin::RegionsController < AdminController
  unloadable
  before_filter :find_region, :only => [:edit, :update, :destroy]
  before_filter :add_crumbs, :except => :index

  def index
    add_breadcrumb "Regions"
    @regions = Region.all
  end

  def new
    add_breadcrumb "New"
    @region = Region.new
  end

  def edit
    add_breadcrumb "Edit"
  end

  def create
    @region = Region.new(params[:region])
    if @region.save
      flash[:notice] = "Region, \"#{@region.name}\" created."
      redirect_to admin_regions_path
    else
      render :action => "new"
    end
  end

  def update
    if @region.update_attributes(params[:region])
      flash[:notice] = "Region \"#{@region.name}\" updated."
      redirect_to admin_regions_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @region.destroy
    respond_to :js
  end
  private
  def add_crumbs
    add_breadcrumb "Regions", admin_regions_path
  end

  def find_region
    @region = Region.find(params[:id])
  end


end

