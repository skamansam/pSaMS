class AddCommentForToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :comment_for_id, :integer
    add_column :comments, :comment_for_type, :string
  end

  def self.down
    remove_column :comments, :comment_for_id
    remove_column :comments, :comment_for_type
  end
end
