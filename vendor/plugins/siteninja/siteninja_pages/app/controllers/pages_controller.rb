class PagesController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001

  def show
    begin
      @page = Page.find_by_permalink! params[:id]
      @footer_pages = Page.find(:all, :conditions => {:show_in_footer => true}, :order => :footer_pos )
      if @page.permalink == "home"
        @features = Feature.find(:all, :order => :position)
      end
      articles = Article.published
      @article_categories = ArticleCategory.active
      @article_archive = articles.group_by { |a| [a.published_at.month, a.published_at.year] }
      @article_authors = User.active.find(:all, :conditions => "articles_count > 0")
      @article_tags = articles.tag_counts.sort_by(&:name)
      @recent_articles = articles[0...5]
    rescue ActiveRecord::RecordNotFound
      redirect_to '/404.html'
    end
    @pages_tmp = []
      build_tree(@page)
      for page in @pages_tmp.reverse
        unless page == @page
          add_breadcrumb page.name, page_path(page)
        else
          add_breadcrumb page.name
        end
      end
  end

private

 def build_tree(current_page)
      @pages_tmp << current_page
   if current_page.parent
      parent_page = current_page.parent
      build_tree(parent_page)
    end
  end



end

