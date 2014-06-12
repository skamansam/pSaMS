class AddNewsFlagToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :is_news, :boolean, :default=>false
  end

  def self.down
    remove_column :posts, :is_news
  end
end
