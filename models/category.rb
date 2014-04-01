class Category < ActiveRecord::Base
  include Tree
  belongs_to :parent, :class_name=>Category, :foreign_key=>:parent_id
  has_many :children, :class_name=>Category, :foreign_key=>:parent_id
  has_many :posts
  
  default_scope { order('item_order DESC') }
  
  def all_posts
    return self.posts + self.children.map(&:all_posts)
  end
end
