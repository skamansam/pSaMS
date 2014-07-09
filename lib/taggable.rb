module Taggable
  def self.included(base)
    base.instance_eval <<-_END
      has_many :tags, as: :for_object
    _END
    base.extend(ClassMethods)
  end
  
  module ClassMethods
  end

  def tag_names
  tags.map(&:name)
  end

  def tag_names=(name)
    self_tag_names = tag_names.sort
    
    #do nothing if we already have the tag
    return name if self_tag_names.include?(name)

    # if there exist
    all_tag_names = Tag.all.map(&:name)

    name
  end

end
