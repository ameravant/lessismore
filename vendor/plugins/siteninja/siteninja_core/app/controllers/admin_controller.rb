class AdminController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  skip_before_filter :cms_for_layout
  before_filter :login_required
  before_filter :set_admin_variable
  before_filter :add_dashboard_breadcrumb

  uses_tiny_mce :options => {
    :theme => 'advanced',
    :theme_advanced_toolbar_align => "left",
    :theme_advanced_toolbar_location => "top",
    :theme_advanced_buttons1_add => "save",
    :theme_advanced_buttons2_add => "pasteword,search,replace,fullscreen",
    :theme_advanced_buttons3_add => "tablecontrols",
    :plugins => %w{ table fullscreen advimage advlink paste safari searchreplace contextmenu save },
    :external_image_list_url => "/tinymce/generate_images_list",
    :external_link_list_url => "/tinymce/generate_links_list",
    :relative_urls => false,
    :width => "850px",
    :content_css => "/stylesheets/tinymce.css" }

  def index
  end
  
  private
  
  def set_admin_variable
    @admin = true
    @settings = Setting.first
  end
  
  def add_dashboard_breadcrumb
    add_breadcrumb "Dashboard", "admin_path"
  end
  
end
