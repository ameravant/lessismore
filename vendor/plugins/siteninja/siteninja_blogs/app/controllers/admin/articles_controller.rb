class Admin::ArticlesController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_article, :only => [ :edit, :update, :destroy, :reorder, :show ]
  before_filter :find_article_categories, :only => [ :new, :create, :edit, :update ]
  #add_breadcrumb "Articles", "admin_articles_path", :only => [ ]

  def index
    if params[:q].blank?
      @all_articles = Article.all
    else
      @all_articles = Article.find(:all, :conditions => ["title like ?", "%#{params[:q]}%"])
    end
    add_breadcrumb "Articles"
    @articles = @all_articles.paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @images = @article.images.find :all, :order => "position"
  end

  def new
    add_breadcrumb "New"
    @article = current_user.articles.build
  end

  def edit
    add_breadcrumb "Edit"
  end

  def create
    @article = current_user.articles.build(params[:article])
    if @article.save
      flash[:notice] = "Article \"#{@article.title}\" created."
      redirect_to admin_articles_path
    else
      render :action => "new"
    end
  end

  def reorder
    params["images"].each_with_index do |id, position|
      Image.update(id, :position => position + 1)
    end
    render :nothing => true
  end

  def update
    if @article.update_attributes(params[:article])
      flash[:notice] = "Article \"#{@article.title}\" updated."
      redirect_to admin_articles_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @article.destroy
    respond_to :js
  end

  private

  def find_article
    begin
      @article = Article.find(params[:id])
    rescue
      flash[:error] = "Article not found."
      redirect_to admin_articles_path
    end
  end

  def find_article_categories
    @article_categories = ArticleCategory.active
  end

end

