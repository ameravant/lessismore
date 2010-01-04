class Admin::SettingsController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :get_settings
  add_breadcrumb "Settings", nil

  def edit
  end

  def update
    if @settings.update_attributes(params[:settings])
      flash[:notice] = "Settings have been updated."
      redirect_to edit_admin_setting_path
    else
      render :action => "edit"
    end
  end
  
  private
  
  def get_settings
    @settings = Setting.first
  end
  
end
