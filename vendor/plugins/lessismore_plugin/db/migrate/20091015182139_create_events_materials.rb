class CreateEventsMaterials < ActiveRecord::Migration
  def self.up
    create_table :events_materials, :id => false do |t|
      t.integer :event_id, :material_id
    end
  end

  def self.down
    drop_table :events_materials
  end
end

