class AddAltTitles < ActiveRecord::Migration
  def self.up
    add_column :materials, :introduction_banner_title, :string
    add_column :material_categories, :introduction_banner_title, :string
  end

  def self.down
    remove_column :material_categories, :introduction_banner_title
    remove_column :materials, :introduction_banner_title
  end
end
