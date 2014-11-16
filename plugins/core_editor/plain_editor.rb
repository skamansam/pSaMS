class PlainEditor

  def self.info
    ["Core Editor: Plain v1.0","Adds a plain-text editor for posts."]
  end

  def initialize
    logger.info "Initializing CoreEditor/PlainEditor"
  end

  def self.setup
    Plugin.add_action('add_editor', 'admin.posts.edit', "PlainEditor", 'get_post_editor',0)
  end

  def get_post_editor(context,form,error)
    { name: 'Plain Text',
      body: context.partial("core_editor/html/plain_editor.haml", locals: {f: form, error: error})
    }
  end

end
