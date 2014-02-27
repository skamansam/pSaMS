class AddOrderToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories,:order, :integer
    add_column :categories,:parent_id, :integer
  end

  def self.down
    remove_column :categories,:order, :integer
    remove_column :categories,:parent_id, :integer
  end
end
