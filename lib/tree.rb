module Tree
  PATH_DELIMITER = '/'.freeze

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
      marker = child == ordered_children.last ? options[:end_marker] : options[:parent_marker]
      child.name = marker + (options[:cur_indent] + options[:indent])
      ret << child
      options[:cur_indent] = options[:indent] unless options.has_key? :cur_indent
      options[:cur_indent] += options[:indent]
      ret += child.children_with_indent(options)
    end
    ret
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

  def find_by_path(path, start_node)
    names = path.is_a?(Array) ? path : path.split(PATH_DELIMITER)
    return start_node if names.size < 2
    possible_child_nodes = start_node.children.select{ |c| c.name == names.first }
    return nil if possible_child_nodes.empty?
    possible_child_nodes.each do |node|
      node = find_by_path(names[1..-1],node)
      return node if node.present?
    end
    nil
  end
end
