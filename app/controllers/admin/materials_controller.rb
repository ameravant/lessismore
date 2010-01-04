class Admin::MaterialsController < AdminController
unloadable
  before_filter :find_material, :except => [ :index, :new, :create ]
  before_filter :find_material_categories, :except => :index
  before_filter :find_locations, :except => :index
  before_filter :add_crumbs, :except => :index
  def index
    add_breadcrumb "Material"
    @materials = Material.all :include => :material_category
  end

  def new
    add_breadcrumb "New"
    @material = Material.new
    @materials = Material.all
  end

  def create
    @material = Material.new params[:material]
    if @material.save
      flash[:notice] = "#{@material.name} created."
      redirect_to admin_materials_path
    else
      render :action => "new"
    end
  end

  def edit
    add_breadcrumb "Edit"
    @materials = Material.all
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy

    respond_to do |wants|
      wants.html { redirect_to admin_events_path }
      wants.js
    end
  end

  def update
    if @material.update_attributes params[:material]
      flash[:notice] = "#{@material.name} updated."
      redirect_to admin_materials_path
    else
      render :action => "edit"
    end
  end


  private
  def add_crumbs
    add_breadcrumb "Material", admin_materials_path
  end

  def find_material
    begin
      @material = Material.find params[:id]
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Material not found."
      redirect_to admin_materials_path
    end
  end

  def find_material_categories
    @material_categories = MaterialCategory.all
  end

  def find_locations
    @locations = Location.all
  end

end

