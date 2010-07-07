class AddUpdatedAtToMaterials < ActiveRecord::Migration
  def self.up
    add_timestamps :materials
    Material.all.each do |m|
      m.touch
      m.touch(:created_at)
    end
  end

  def self.down
    remove_timestamps :materials
  end
end
