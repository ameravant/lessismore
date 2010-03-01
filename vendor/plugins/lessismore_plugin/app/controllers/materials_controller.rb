class MaterialsController < ApplicationController
  def show
    @material = Material.find params[:id]
    @material_category = @material.material_category
    @locations = @material.locations
    @page = Page.find_by_permalink(@material_category.permalink)
    @sub_pages = Page.find(:all, :conditions => {:parent_id => @page.id})
    @sub_materials = @material_category.materials.sort_by(&:position)
    add_breadcrumb "Home", "/"
    add_breadcrumb @material_category.name, @material_category
    add_breadcrumb @material.name

  end
  def index
    @materials = Material.all
  end
end

