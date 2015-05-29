class KatexEquations

  def self.info
    ["Katex Equations v1.0","Add support for processing Latex in posts."]
  end

  def initialize
    logger.info "Initializing KatexEquations Class"
  end

  def self.migrate ; end

  def self.setup
    Plugin.add_action('add_css', 'posts', "KatexEquations", 'get_css',0)
    Plugin.add_action('add_js', 'posts', "KatexEquations", 'get_js',0)
    Plugin.add_filter('post_body_class', "KatexEquations", 'add_katex_class')
    Plugin.add_filter('post_content', "KatexEquations", 'make_equations')
  end

  def get_css
    '<link rel="stylesheet" href="'+katex_path+'katex.min.css"></script>'.html_safe
  end

  def get_js
    '<script type="text/javascript" src="'+katex_path+'katex.min.js"></script>' +
    '<script type="text/javascript" src="'+katex_path+'bootstrap-wysiwyg.js"></script>' +
    '<script type="text/javascript" src="'+katex_path+'contrib/auto-render.min.js"></script>' +
    '<script type="text/javascript" src="/assets/katex_equations/katex_equations.js"></script>'.html_safe
  end

  def add_katex_class(body_class, post)
    "#{body_class} katex"
  end

  def make_equations(body_text, post)
    #binding.pry
    ret = body_text
    #{
    #  inline_equation: [ /\\\([^\!](.*?)[^\!]\\\)/, /\$\$[^\!](.*?)[^\!]\$\$/ ],
    #  single_line_equation: [ /\\\[[^\!](.*?)[^\!]\\\]/, /\$\$\!(.*?)\$\$/ ],
    #  #show_latex_source: [ /\\\((.*?)\!\\\)/ ]
    #}.each do |class_name, rgxes|
    #  rgxes.each do |rgx|
    #    ret.gsub! rgx, "<span class='#{class_name}'>\\1</span>"
    #  end
    #end
    ret
  end

  private

  def katex_path
    "/assets/katex_equations/katex/"
  end


end
