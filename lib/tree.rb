module Tree
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def top_level
      where "parent_id is null"
    end
  end
  
  def children_with_indent(options={:parent_marker=>'|',:indent=>"--",:end_marker=>'-'})
    ret = []
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
