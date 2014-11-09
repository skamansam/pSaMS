require_relative 'plain_editor.rb'
require_relative 'markdown_editor.rb'
require_relative 'html_editor.rb'

class CoreEditor
  
  def self.info
    ["Core Editor v1.0","Adds a plain-text editor, a markdown editor, and an HTML editor for posts."]
  end

  def initialize
    logger.info "Initializing CoreEditor"
  end

  def self.migrate ; end

  def self.setup
    PlainEditor.setup
    MarkdownEditor.setup
    HtmlEditor.setup
  end

end
