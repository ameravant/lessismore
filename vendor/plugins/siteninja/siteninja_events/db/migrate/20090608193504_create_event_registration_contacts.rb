class CreateEventRegistrationContacts < ActiveRecord::Migration
 def self.up
    create_table :event_registration_contacts do |t|
      t.integer :contact_id, :registration_id, :event_price_id, :null => false
      t.boolean :owner, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :event_registration_contacts
  end

end
