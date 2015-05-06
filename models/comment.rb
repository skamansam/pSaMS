# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :text
#  title            :string
#  user_id          :integer
#  email            :string
#  created_at       :datetime
#  updated_at       :datetime
#  comment_for_id   :integer
#  comment_for_type :string
#

# This represetns a comment. A comment is a publicly-createable object that
# can be for anyother object (via polymorphic association).
class Comment < ActiveRecord::Base
  belongs_to :comment_for, polymorphic: true

  def parent
    comment_for
  end

  def children
    Comment.where(comment_for_type: 'Comment', comment_for_id: id)
  end
end
