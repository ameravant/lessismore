class CreateArticlesMaterials < ActiveRecord::Migration
  def self.up
    create_table :articles_materials, :id => false do |t|
      t.integer :article_id, :material_id
    end
  end

  def self.down
    drop_table :articles_materials
  end
end

