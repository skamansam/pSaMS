class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.string :title
      t.text :body
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :news
  end
end
