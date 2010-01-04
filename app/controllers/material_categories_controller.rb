class MaterialCategoriesController < ApplicationController
unloadable
  def show
    @material_category = MaterialCategory.find params[:id]
    @articles = @material_category.articles.published
    @events = @material_category.events
    @materials = @material_category.materials.sort_by(&:name)
    @page = Page.find_by_permalink(@material_category.permalink)
    @sub_pages = Page.find(:all, :conditions => {:parent_id => @page.id})
    @sub_materials = @material_category.materials.sort_by(&:position)
    add_breadcrumb "Home", "/"
    add_breadcrumb @material_category.name
  end

end

