include Plugin::Filter

class SimpleReplace
  def initialize
    puts "Initiializing SimpleReplace Module"
  end
  def filter_content(content)
    "This has been filtered!"
  end
end
register_filter('the_content', SimpleReplace, 'filter_content')
