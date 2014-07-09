class Tag < ActiveRecord::Base
  belongs_to :for_object, polymorphic: true
  validates_presence_of :for_object

  def for(klass, prop: nil)
    where for_object_type: klass, for_property: prop
  end

  def for_tag_name(tag_name)
    where name: tag_name
  end
end
