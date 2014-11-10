class HtmlEditor
  include Haml

  def self.info
    ["Core Editor: HTML v1.0","Adds an HTML editor for posts."]
  end

  def initialize
    logger.info "Initializing CoreEditor::Html"
  end

  def self.migrate ; end

  def self.setup
    Plugin.add_action('add_editor', 'admin.posts.edit', "HtmlEditor", 'get_post_editor',0)
    Plugin.add_action('add_css', 'admin.posts.edit', "HtmlEditor", 'get_css',0)
    Plugin.add_action('add_js', 'admin.posts.edit', "HtmlEditor", 'get_js',0)
  end

  def get_post_editor(context,form,error)
    { name: 'HTML',
      body: context.partial("core_editor/html/post_editor.haml", locals: {f: form, error: error})
    }
  end

  def get_css
    "<!-- SimpleEditor CSS goes here -->".html_safe
  end
  def get_js
    "<!-- SimpleEditor JS goes here -->".html_safe
  end
end
