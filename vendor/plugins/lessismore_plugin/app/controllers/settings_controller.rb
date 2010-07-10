class SettingsController < ApplicationController
  unloadable
  def additional_styles
    @settings = Setting.first
    respond_to do |wants|
      wants.css { render :css => @settings.additional_styles } 
    end  
  end
  def javascript
    @settings = Setting.first
    respond_to do |wants|
      wants.js { render :js => @settings.javascript } 
    end  
  end
end
