class CreateFileUploads < ActiveRecord::Migration
  def self.up
    create_table :file_uploads do |t|
      t.string :name
      t.text :description
      t.string :location
      t.string :size_small
      t.string :size_medium
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :file_uploads
  end
end
