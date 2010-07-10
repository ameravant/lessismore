class CreateRedirectTable < ActiveRecord::Migration
  def self.up
    create_table :redirects, :force => true do |t|
      t.string :from_url
      t.string :to_url
      t.timestamps
    end
  end

  def self.down
    drop_table :redirects
  end
end
