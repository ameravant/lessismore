class SearchesController < ApplicationController

  def index
  @page = Page.find_by_permalink("result")
  if params[:q].blank?
    render :index
  else
    material_builder = "Material"
    material_category_builder = "MaterialCategory"
    for parameter in params[:q].to_s.split
      material_builder << ".search_keywords_or_name_like(\"#{parameter}\")"
      material_category_builder << ".name_like(\"#{parameter}\")"
    end
    @search_results = []
    @search_results << eval(material_builder)
    @search_results << eval(material_category_builder)
    respond_to do |wants|
      wants.html do
        if @search_results.flatten.length == 1 
          if @search_results.flatten[0].class == MaterialCategory
            redirect_to material_category_path(@search_results.flatten[0])
          elsif @search_results.flatten[0].class == Material
            redirect_to material_path(@search_results.flatten[0].id)
          else
            redirect_to searches_path
          end
        end
      end
      wants.js {searches_path}
    end
    end
#    respond_to do |format|
#      format.html #index.html.erb
#      format.js # index.js.erb
#    end
  end

#  def new
#    @all_material_categories = MaterialCategory.all
#    return if params[:q].blank?

#    @search = params[:q].strip
#    search_stripped = @search.gsub(/\W/,'')
#    search_singular = @search.singularize # to search plural alternative
#    search_plural = @search.pluralize # to search singular alternative
#    one_match_text = "We found exactly one match and have taken you to it."

#    # Seach material keyword or name matches
#    @materials = Material.find :all, :include => :material_category, :conditions => [
#      "search_keywords like ? or search_keywords like ? or search_keywords like ? or search_keywords like ?
#      or name like ? or name like ? or name like ? or name like ?",
#      "%#{@search}%", "%#{search_stripped}%", "%#{search_singular}%", "%#{search_plural}%",
#      "%#{@search}%", "%#{search_stripped}%", "%#{search_singular}%", "%#{search_plural}%"]
#    if @materials.size == 1
#      flash[:notice] = one_match_text
#      redirect_to material_path(@materials.first, :q => @search)
#    end
#
#    # Search material category
#    @material_categories = MaterialCategory.find :all, :conditions => [
#      "name like ? or name like ? or name like ? or name like ?",
#      "%#{@search}%", "%#{search_stripped}%", "%#{search_singular}%", "%#{search_plural}%"]
#    if @material_categories.size == 1
#      flash[:notice] = one_match_text
#      redirect_to material_category_path(@material_categories.first, :q => @search)
#    end
#
#    # Search other resources
#    @locations = Location.find :all, :conditions => ["name like ? or name like ?", "%#{@search}%", "%#{search_stripped}%"], :limit => 5
#    @articles = Article.find :all, :conditions => ["title like ? or title like ?", "%#{@search}%", "%#{search_stripped}%"], :limit => 5
#    @events = Event.find :all, :conditions => ["name like ? or name like ?", "%#{@search}%", "%#{search_stripped}%"], :limit => 5
#
#  end
end

