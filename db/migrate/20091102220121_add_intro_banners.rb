class AddIntroBanners < ActiveRecord::Migration
  def self.up
    add_column :pages, :introduction_banner_headline, :string
    add_column :pages, :introduction_banner_image_file_name, :string
    add_column :pages, :introduction_banner_image_content_type, :string
    add_column :pages, :introduction_banner_image_file_size, :integer
    add_column :pages, :introduction_banner_image_updated_at, :datetime
    add_column :pages, :introduction_banner_body, :text
  end

  def self.down
    remove_column :pages, :introduction_banner_headline
    remove_column :pages, :introduction_banner_image_file_name
    remove_column :pages, :introduction_banner_image_content_type
    remove_column :pages, :introduction_banner_image_file_size
    remove_column :pages, :introduction_banner_image_updated_at
    remove_column :pages, :introduction_banner_body
  end
  
end
