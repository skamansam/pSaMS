class AddPathToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts,:path, :string
  end

  def self.down
    remove_column :posts,:path
  end
end
