class Comment < ActiveRecord::Base
  belongs_to :comment_for, polymorphic: true
  
end
