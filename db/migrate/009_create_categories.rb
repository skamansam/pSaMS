class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
    add_column :posts, :category_id, :integer
  end

  def self.down
    drop_table :categories
    remove_column :posts, :category_id
  end
end
