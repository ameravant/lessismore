class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name, :address, :address2, :city, :state, :zip, :phone, :email, :website
      t.string :geokit_precision, :geokit_provider, :geokit_accuracy
      t.string :permalink
      t.text :description
      t.boolean :geokit_success, :default => false
      t.float :lat, :lng
      t.integer :region_id
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end

