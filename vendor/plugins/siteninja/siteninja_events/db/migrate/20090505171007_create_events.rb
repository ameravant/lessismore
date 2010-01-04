class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name, :permalink, :address
      t.text :description
      t.datetime :date_and_time
      t.integer :user_id

      # Registration-specific fields
      t.integer :registration_limit
      t.text :check_instructions, :registration_closed_text
      t.boolean :registration, :allow_cash, :allow_check, :default => false
      t.boolean :allow_card, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
