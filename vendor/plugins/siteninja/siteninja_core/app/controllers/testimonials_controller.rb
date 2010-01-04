class TestimonialsController < ApplicationController
  before_filter :find_owner_and_get_page
  
  def index
    @testimonials = @owner.testimonials
    add_breadcrumb "Home", "root_path" 
    add_breadcrumb @page.name
  end
  
  def find_owner_and_get_page
    if params[:article_id]
      @owner = Article.find params[:article_id]
    elsif params[:gallery_id]
      @owner = Gallery.find params[:gallery_id]
    elsif params[:product_id]
      @owner = Product.find params[:product_id]
    elsif params[:page_id]
      @owner = Page.find_by_permalink params[:page_id]
    else
      @owner = Page.find_by_permalink("testimonials")
    end
    @page = Page.find_by_permalink!("testimonials")
    @footer_pages = Page.find(:all, :conditions => {:show_in_footer => true}, :order => :footer_pos )
  end
end
