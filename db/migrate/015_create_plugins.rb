class CreatePlugins < ActiveRecord::Migration
  def self.up
    create_table :plugins do |t|
      t.string :name
      t.integer :priority
      t.string :location
      t.string :type
      t.string :method_name
      t.string :class_name
      t.string :hook_name
      t.text :options
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :plugins
  end
end
