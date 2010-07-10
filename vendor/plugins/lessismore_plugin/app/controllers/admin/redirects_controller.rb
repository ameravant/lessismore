class Admin::RedirectsController < AdminController
unloadable
  before_filter :find_redirect, :except => [ :index, :new, :create ]
  def index
    @redirects = Redirect.all
  end

  def new
    @redirect = Redirect.new
  end

  def create
    @redirect = Redirect.new params[:redirect]
    if @redirect.save
      flash[:notice] = "Redirect created."
      redirect_to admin_redirects_path
    else
      render :action => "new"
    end
  end

  def edit
    add_breadcrumb "Edit"
  end

  def destroy
    @redirect = Redirect.find_by_id(params[:id])
    @redirect.destroy
    respond_to do |wants|
      wants.js
    end
  end

  def update
    if @redirect.update_attributes params[:redirect]
      flash[:notice] = "Redirect updated."
      redirect_to admin_redirects_path
    else
      render :action => "edit"
    end
  end


  private
  def add_crumbs
    add_breadcrumb "redirect", admin_redirects_path
  end

  def find_redirect
    begin
      @redirect = Redirect.find_by_id params[:id]
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "redirect not found."
      redirect_to admin_redirects_path
    end
  end
  
end

