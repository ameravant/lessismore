class CreateMaterialCategories < ActiveRecord::Migration
  def self.up
    create_table :material_categories do |t|
      t.string :name, :short_name, :permalink, :css_class, :introduction_banner_headline, :introduction_banner_image_file_name,:introduction_banner_image_content_type
      t.text :introduction_banner_body, :body
      t.integer :introduction_banner_image_file_size
      t.datetime :introduction_banner_image_updated_at
    end
  end

  def self.down
    drop_table :material_categories
  end
end

