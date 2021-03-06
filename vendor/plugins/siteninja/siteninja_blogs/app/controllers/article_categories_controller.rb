class ArticleCategoriesController < ApplicationController
  unloadable
  add_breadcrumb 'Home', 'root_path'
  add_breadcrumb 'Articles', 'blog_path'
  before_filter :find_page
  before_filter :find_articles_for_sidebar
  
  def show
    begin
      @page = Page.find_by_permalink!('blog')
      @article_category = ArticleCategory.active.find(params[:id])
      @articles = @article_category.articles.published.paginate(:page => params[:page], :per_page => 10)
      add_breadcrumb @article_category.name
    rescue ActiveRecord::RecordNotFound
      redirect_to '/404.html'
    end
  end

  private
  
  def find_page
    @footer_pages = Page.find(:all, :conditions => {:show_in_footer => true}, :order => :footer_pos )
    @page = Page.find_by_permalink!('blog')
  end
  
  def find_articles_for_sidebar
    @article_categories = ArticleCategory.active
    @article_archive = Article.published.group_by { |a| [a.published_at.month, a.published_at.year] }
    @article_authors = User.active.find(:all, :conditions => "articles_count > 0")
    @article_tags = Article.published.tag_counts.sort_by(&:name)
  end
  
end
