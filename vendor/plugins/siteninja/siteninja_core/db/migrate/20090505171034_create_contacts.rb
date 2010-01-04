class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :first_name, :last_name, :company, :title
      t.string :email, :phone
      t.string :address, :address_2, :city, :state, :zip
      t.references :contactable, :polymorphic => true
      t.timestamps
    end
    
  end

  def self.down
    drop_table :contacts
  end
end

