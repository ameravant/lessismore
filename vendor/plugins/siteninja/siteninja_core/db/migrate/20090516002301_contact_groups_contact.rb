class ContactGroupsContact < ActiveRecord::Migration
  def self.up
    create_table :contact_groups_contacts, :id => false do |t| 
      t.integer :contact_id, :contact_group_id
    end
  end

  def self.down
    drop_table :contact_groups_contacts
  end
end
