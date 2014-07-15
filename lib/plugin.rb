module Plugin
  include Action
  include Filter
  include Editor
  include Page
  
  attr_reader :page_refs

  def self.included(base)
    #base.send(:include, AssetTagHelpers)
    #base.extend ClassMethods
  end

end
