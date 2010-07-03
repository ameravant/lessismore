class AddMapFieldToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :map_link, :string
  end

  def self.down
    remove_column :locations, :map_link
  end
end
