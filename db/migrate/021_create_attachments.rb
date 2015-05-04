class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string      :attachment_for_type
      t.integer     :attachment_for_id
      t.string      :file
      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
