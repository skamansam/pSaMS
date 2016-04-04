class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.text :exif_info
      t.text :about
      t.string :location
      t.string :title
      t.string :thumbnail_location
      t.integer :album_id
      t.string :filename
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :photos
  end
end
