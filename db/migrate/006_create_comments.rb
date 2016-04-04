class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.string :title
      t.integer :user_id
      t.string :email
      t.datetime :created_at
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :comments
  end
end
