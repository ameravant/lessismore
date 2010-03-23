class Admin::EventsController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_event, :only => [ :edit, :update, :destroy, :restore ]

  # Configure breadcrumb
  add_breadcrumb "Events", "admin_events_path", :except => :index
  add_breadcrumb "New", nil, :only => [ :new, :create ]
  

  def index
    if params[:q].blank?
      add_breadcrumb "Events"
     @all_events = Event.future
    else
      add_breadcrumb "Events", "admin_events_path"
      add_breadcrumb "Search"
      @all_events = Event.find :all, :conditions => ["name like ?", "#{params[:q]}%"], :order => "date_and_time desc"
    end
    @events = @all_events.sort_by(&:created_at).reverse.paginate(:page => params[:page], :per_page => 50)
  end

  def new
    @event = Event.new
    @materials = Material.all
    @material_categories = MaterialCategory.all
  end

  def edit
    add_breadcrumb @event.name, nil
    @materials = Material.all
    @material_categories = MaterialCategory.all
  end

  def create
    @event = current_user.events.build(params[:event])
    if @event.save
      flash[:notice] = "#{@event.name} created."
      redirect_to admin_events_path
    else
      render :action => "new"
    end
  end

  def update
    if @event.update_attributes(params[:event])
      flash[:notice] = "#{@event.name} updated."
      redirect_to admin_events_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @event.destroy
    respond_to :js
  end

  private

    def find_event
      begin
        @event = Event.find(params[:id])
      rescue
        flash[:error] = "Event not found."
        redirect_to admin_events_path
      end
    end

end

