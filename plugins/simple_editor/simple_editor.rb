class SimpleEditor

  def self.info
    ["Simple Editor v1.0","Adds a simple editor to the post editor."]
  end

  def initialize
    logger.info "Initiializing SimpleEditor"
  end
  
  def self.migrate ; end
  
  def self.setup
    Plugin.add_action('add_editor', 'admin.posts.edit', "SimpleEditor", 'get_post_editor',0)
    #Plugin.add_action('add_css', 'admin.posts.edit', "SimpleEditor", 'get_css',0)
    #Plugin.add_action('add_js', 'admin.posts.edit', "SimpleEditor", 'get_js',0)
  end
  
  def get_post_editor(content, post)
    #render './html/post_editor'
  end

end
