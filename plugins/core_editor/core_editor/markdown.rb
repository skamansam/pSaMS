class CoreEditor::Markdown
  include Haml

  def self.info
    ["Core Editor v1.0","Adds a plain-text editor, a markdown editor, and an HTML editor for posts."]
  end

  def initialize
    logger.info "Initializing CoreEditor::Markdown"
  end

  def self.migrate ; end

  def self.setup
    Plugin.add_action('add_editor', 'admin.posts.edit', "CoreEditor::Markdown", 'get_post_editor',0)
    Plugin.add_action('add_css', 'admin.posts.edit', "CoreEditor::Markdown", 'get_css',0)
    Plugin.add_action('add_js', 'admin.posts.edit', "CoreEditor::Markdown", 'get_js',0)
  end

  def get_post_editor(context,form,error)
    context.partial "simple_editor/html/post_editor.haml", locals: {f: form, error: error}
  end

  def get_css
    "<!-- SimpleEditor CSS goes here -->".html_safe
  end
  def get_js
    "<!-- SimpleEditor JS goes here -->".html_safe
  end
end
