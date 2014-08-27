class AddHookLocationToPlugins < ActiveRecord::Migration
  def self.up
    add_column :plugins, :hook_location, :string, :default=>'*'
  end

  def self.down
    remove_column :plugins, :hook_location
  end
end
