class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|

      # Template settings
      t.string :logo_file_name, :logo_content_type, :introduction_banner_image_file_name
      t.integer :logo_file_size
      t.datetime :logo_updated_at
      t.text :footer_text, :tracking_code
      
      # Core settings
      t.string :inquiry_notification_email

      # Homepage settings
      t.boolean :show_features, :default => true
      t.boolean :show_feature_thumbs, :default => true
      t.boolean :show_testimonials, :default => true
      t.string  :introduction_banner_headline
      t.text    :introduction_banner_body

      # Blog settings
      t.boolean :comment_profanity_filter, :default => true
      t.boolean :show_tags_in_sidebar, :default => true
      t.boolean :show_authors_in_sidebar, :default => true
      t.boolean :show_categories_in_sidebar, :default => true
      t.boolean :show_archive_in_sidebar, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
