class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :title
      t.string :caption
      t.integer :user_id
      t.references :viewable, :polymorphic => true
      t.integer :position, :default => 1

      # Paperclip fields
      t.string :image_file_name, :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
