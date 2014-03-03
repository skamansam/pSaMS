class AddOrderAndParentIdToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories,:item_order, :integer
    add_column :categories,:parent_id, :integer
  end

  def self.down
    remove_column :categories,:item_order, :integer
    remove_column :categories,:parent_id, :integer
  end
end
