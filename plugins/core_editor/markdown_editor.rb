class MarkdownEditor
  include Haml

  def self.info
    ["Core Editor: Markdown v1.0","Adds a plain-text editor, a markdown editor, and an HTML editor for posts."]
  end

  def initialize
    logger.info "Initializing CoreEditor::Markdown"
  end

  def self.migrate ; end

  def self.setup
    Plugin.add_action('add_editor', 'admin.posts.edit', "MarkdownEditor", 'get_post_editor',0)
    Plugin.add_action('add_css', 'admin.posts.edit', "MarkdownEditor", 'get_css',0)
    Plugin.add_action('add_js', 'admin.posts.edit', "MarkdownEditor", 'get_js',0)
  end

  def get_post_editor(context,form,error)
    { name: 'Markdown',
      body: context.partial("core_editor/html/markdown_editor.haml", locals: {f: form, error: error})
    }
  end

  def get_css
    "<!-- MarkdownEditor CSS goes here -->".html_safe
  end
  def get_js
    "<!-- MarkdownEditor JS goes here -->".html_safe
  end
end
