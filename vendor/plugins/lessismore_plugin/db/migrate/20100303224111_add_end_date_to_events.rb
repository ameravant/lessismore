class AddEndDateToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :end_date_and_time, :datetime
  end

  def self.down
    remove_column :events, :end_date_and_time
  end
end
