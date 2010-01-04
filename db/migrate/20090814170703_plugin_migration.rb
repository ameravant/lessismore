class PluginMigration < ActiveRecord::Migration
  def self.up
    Engines.plugins["siteninja_blogs"].migrate(20090813202612)
    Engines.plugins["siteninja_core"].migrate(20090721220516)
    Engines.plugins["siteninja_events"].migrate(20090608193504)
    Engines.plugins["siteninja_pages"].migrate(20090603191812)
  end

  def self.down
    Engines.plugins["siteninja_blogs"].migrate(0)
    Engines.plugins["siteninja_core"].migrate(0)
    Engines.plugins["siteninja_events"].migrate(0)
    Engines.plugins["siteninja_pages"].migrate(0)
  end
end
