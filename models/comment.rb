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
  has_many :comments, as: :comment_for

  alias_method :children, :comments

  def parent
    comment_for
  end

end
