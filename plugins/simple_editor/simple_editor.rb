class SimpleEditor
  include Haml
  #require 'application.rb'
  include Padrino::Helpers
  include Padrino::Helpers::RenderHelpers
  include Padrino::Rendering::SafeTemplate
  def self.info
    ["Simple Editor v1.0","Adds a simple editor to the post editor."]
  end

  def initialize
    logger.info "Initializing SimpleEditor"
  end

  def self.migrate ; end

  def self.setup
    Plugin.add_action('add_editor', 'admin.posts.edit', "SimpleEditor", 'get_post_editor',0)
    Plugin.add_action('add_css', 'admin.posts.edit', "SimpleEditor", 'get_css',0)
    Plugin.add_action('add_js', 'admin.posts.edit', "SimpleEditor", 'get_js',0)
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
