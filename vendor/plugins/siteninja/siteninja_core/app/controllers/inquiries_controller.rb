class InquiriesController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  add_breadcrumb "Home", "root_path"
  before_filter :find_page

  def new
    @page = Page.find_by_permalink!('inquire')
    add_breadcrumb "#{@page.name}", nil
    @inquiry = Inquiry.new    
  end
  
  def create
    return unless params[:first_name].blank? # spam bots will fill this hidden field out
    @inquiry = Inquiry.new(params[:inquiry])
    render :action => "new" unless @inquiry.save
    @inquiry_page = Page.find_by_permalink!('inquire')
    @page = Page.find_by_permalink!('inquiry_received') # used in create view
    add_breadcrumb "#{@inquiry_page.name}", "\"/#{@inquiry_page.permalink}\""
    add_breadcrumb "Message sent"
  end
  
  def find_page
    @footer_pages = Page.find(:all, :conditions => {:show_in_footer => true}, :order => :footer_pos )
    @page = Page.find_by_permalink!('inquire')
    @article_categories = ArticleCategory.active
    @article_archive = Article.published.group_by { |a| [a.published_at.month, a.published_at.year] }
    @article_authors = User.active.find(:all, :conditions => "articles_count > 0")
    @article_tags = Article.published.tag_counts.sort_by(&:name)
  end
  
end
