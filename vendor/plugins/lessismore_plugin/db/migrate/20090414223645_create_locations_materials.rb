class CreateLocationsMaterials < ActiveRecord::Migration
  def self.up
    create_table :locations_materials, :id => false do |t|
      t.integer :location_id, :material_id
    end
  end

  def self.down
    drop_table :locations_materials
  end
end
