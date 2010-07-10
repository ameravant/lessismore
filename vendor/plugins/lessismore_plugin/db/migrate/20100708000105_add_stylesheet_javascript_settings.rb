class AddStylesheetJavascriptSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :additional_styles, :text
    add_column :settings, :javascript, :text
  end

  def self.down
    remove_column :settings, :javascript
    remove_column :settings, :additional_styles
  end
end
