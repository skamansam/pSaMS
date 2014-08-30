class AddHookLocationToPlugins < ActiveRecord::Migration
  def self.up
    add_column :plugins, :context, :string, :default=>'*'
  end

  def self.down
    remove_column :plugins, :context
  end
end
