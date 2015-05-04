class DropNews < ActiveRecord::Migration
  def self.up
    drop_table :news
  end
  def self.down
    create_table :news do |t|
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
