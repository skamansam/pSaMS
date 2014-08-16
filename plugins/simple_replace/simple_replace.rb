class SimpleReplace

  def self.info
    ["Simple Replace v1.0","This filter simply replaces all posts with the text, 'This has been filtered!'"]
  end

  def initialize
    logger.info "Initiializing SimpleReplace Class"
  end
  
  def self.migrate ; end
  
  def self.setup
    Plugin.add_filter('the_content', "SimpleReplace", 'filter_content')
  end
  def filter_content(content, post)
    logger.info "Filtering Content: #{content}"
    "This has been filtered!"
  end

end
