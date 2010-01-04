class CreateMaterialCategoriesMaterials < ActiveRecord::Migration
  def self.up
    create_table :material_categories_materials, :id => false do |t|
      t.integer :material_id, :material_category_id
    end
  end

  def self.down
    drop_table :material_categories_materials
  end
end
