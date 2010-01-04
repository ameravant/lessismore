class Admin::ImagesController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_viewable
  before_filter :find_image, :except => [ :new, :create, :reorder ]
  add_breadcrumb "Galleries", [:admin, @owner]
  add_breadcrumb "@owner.title", "[:admin,@owner]", :only => [:new, :edit, :show]

  def new
    add_breadcrumb "New"
    @image = @owner.images.new
  end
  
  def create
    @image = @owner.images.build(params[:image])      
    if @image.save
      added_to = @title
      redirect_path = [:admin, @owner]
      flash[:notice] = "Image added to #{added_to}"
      redirect_to redirect_path
    else
      render :action => "new"
    end
  end

  def edit
    add_breadcrumb "Edit"
  end
  
  def update
    if @image.update_attributes(params[:image])
      @image = @owner.images.build(params[:image])
      added_to = @owner.title
      redirect_path = [:admin, @owner]
      flash[:notice] = "Image updated!"
      redirect_to redirect_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @image.destroy
    respond_to :js
  end
    
  def reorder
    params["images"].each_with_index do |id, position|
      Image.update(id, :position => position + 1)
    end
    render :nothing => true
  end
  
  private
  
    def find_viewable
      if params[:article_id]
        @owner = Article.find(params[:article_id])
      elsif params[:gallery_id]
        @owner = Gallery.find(params[:gallery_id])
      elsif params[:product_id]
        @owner = Product.find(params[:product_id])
      elsif params[:page_id]
        @owner = Page.find_by_permalink(params[:page_id])
      end
    end
    
    def find_image
      @image = Image.find params[:id]
    end

end
