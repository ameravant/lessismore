class CreateRelatedMaterials < ActiveRecord::Migration
  def self.up
    create_table :related_materials, :force => true, :id => false do |t|
      t.integer :related_material_id
      t.integer :main_material_id
      t.timestamps
    end
  end

  def self.down
    drop_table :related_materials
  end
end

