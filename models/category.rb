class Category < ActiveRecord::Base
  belongs_to :parent, :class_name=>Category, :foreign_key=>:parent_id
  has_many :children, :class_name=>Category, :foreign_key=>:parent_id
  
  default_scope { order('item_order DESC') }

  def self.top_level
    where "parent_id is null"
  end
  
  def children_with_indent(options={:parent_marker=>'|',:indent=>"--",:end_marker=>'-'})
    ret = []
    puts "CHILDREN OF:"
    puts self
    ordered_children = self.children.order_by(:item_order) 
    ordered_children.each do |child|
      child.name = (child == ordered_children.last ? options[:end_marker] : options[:parent_marker]) + (options[:cur_indent] + options[:indent])
      ret << child
      options[:cur_indent] = options[:indent] unless options.has_key? :cur_indent
      options[:cur_indent] += options[:indent]
      ret += child.children_with_indent(options)
    end
    ret
  end

  def flatten_tree(p)
    
  end
  
  def ancestors
    ans = []
    while p = self.parent
      ans << p
    end
    ans
  end

  def siblings
    parent.children - self
  end
  
  def descendants
    des = []
    self.children.each do |c|
      des += c.descendants
    end
    children + des
  end
end
