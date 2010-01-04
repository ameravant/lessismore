class Admin::ArticleCategoriesController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_article_category, :only => [ :edit, :update, :destroy ]
  add_breadcrumb "Articles", "admin_articles_path"
  add_breadcrumb "Categories", "admin_article_categories_path", :except => [ :index, :destroy ]
  add_breadcrumb "New Category", nil, :only => [ :new, :create ]
  add_breadcrumb "@article_category.name", nil, :only => [ :edit, :update ]

  def index
    @article_categories = ArticleCategory.active
    add_breadcrumb "Categories", nil
  end
  
  def new
    @article_category = ArticleCategory.new
  end

  def create
    @article_category = ArticleCategory.new(params[:article_category])
    if @article_category.save
      flash[:notice] = "Category \"#{@article_category.name}\" created."
      redirect_to admin_article_categories_path
    else
      render :action => "new"
    end
  end
  
  def edit
  end
  
  def update
    if @article_category.update_attributes(params[:article_category])
      flash[:notice] = "Category \"#{@article_category.name}\" updated."
      redirect_to admin_article_categories_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @article_category.update_attribute(:active, false)
    respond_to :js
  end
  

  private
  
  def find_article_category
    begin
      @article_category = ArticleCategory.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Article category was not found. It may have been deleted."
      redirect_to admin_article_categories_path
    end
  end

end
