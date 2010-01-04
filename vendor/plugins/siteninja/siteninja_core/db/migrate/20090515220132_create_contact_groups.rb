class CreateContactGroups < ActiveRecord::Migration
  def self.up
    create_table :contact_groups do |t|
      t.string :name
      t.integer :contacts_count, :default => 0
      t.boolean :active, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :contact_groups
  end
end
