class CreatePlugins < ActiveRecord::Migration
  def self.up
    create_table :plugins do |t|
      t.string :name
      t.integer :priority
      t.string :plugin_type
      t.string :file_name
      t.integer :line_number
      t.string :class_name
      t.string :method_name
      t.string :hook_name
      t.integer :num_args
      t.text :options
      t.boolean :active
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :plugins
  end
end
