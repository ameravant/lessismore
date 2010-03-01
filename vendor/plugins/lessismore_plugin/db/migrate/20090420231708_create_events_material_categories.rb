class CreateEventsMaterialCategories < ActiveRecord::Migration
  def self.up
    create_table :events_material_categories, :id => false do |t|
      t.integer :event_id, :material_category_id
    end
  end

  def self.down
    drop_table :events_material_categories
  end
end
