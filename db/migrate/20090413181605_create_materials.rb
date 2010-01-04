class CreateMaterials < ActiveRecord::Migration
  def self.up
    create_table :materials do |t|
      t.string :name, :permalink, :search_keywords, :introduction_banner_headline, :introduction_banner_image_file_name, :introduction_banner_image_content_type
      t.text :description, :introduction_banner_body, :instruction
      t.integer :material_category_id, :introduction_banner_image_file_size
      t.integer :position, :default => 1
      t.boolean :in_sub_menu, :default => true
      t.datetime :introduction_banner_image_updated_at
    end
  end

  def self.down
    drop_table :materials
  end
end

