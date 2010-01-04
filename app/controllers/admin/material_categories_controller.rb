class Admin::MaterialCategoriesController < AdminController
unloadable
  before_filter :find_material_category, :except => [ :index, :new, :create ]
  before_filter :add_crumbs, :except => :index

  def index
    add_breadcrumb "Material Categories"
    @material_categories = MaterialCategory.all
  end

  def new
    add_breadcrumb "New"
    @material_category = MaterialCategory.new
  end

  def create
    @material_category = MaterialCategory.new params[:material_category]
    if @material_category.save
      flash[:notice] = "#{@material_category.name} created."
      redirect_to admin_material_categories_path
    else
      render :action => "new"
    end
  end

  def edit
    add_breadcrumb "Edit"
  end

  def update
    if @material_category.update_attributes params[:material_category]
      flash[:notice] = "#{@material_category.name} updated."
      redirect_to admin_material_categories_path
    else
      render :action => "edit"
    end
  end


  private

  def add_crumbs
    add_breadcrumb "Material Categories", admin_material_categories_path
  end

  def find_material_category
    begin
      @material_category = MaterialCategory.find params[:id]
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Material category not found."
      redirect_to admin_material_categories_path
    end
  end

end

