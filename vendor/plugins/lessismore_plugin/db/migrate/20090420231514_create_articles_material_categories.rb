class CreateArticlesMaterialCategories < ActiveRecord::Migration
  def self.up
    create_table :articles_material_categories, :id => false do |t|
      t.integer :article_id, :material_category_id
    end
  end

  def self.down
    drop_table :articles_material_categories
  end
end
