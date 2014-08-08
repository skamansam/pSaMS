
class SimpleReplace < FilterPlugin
  def initialize
    puts "Initiializing SimpleReplace Module"
    FilterPlugin.add_filter('the_content', SimpleReplace, 'filter_content')
  end
  def filter_content(content,post)
    puts "Filtering Content: #{content}"
    "This has been filtered!"
  end
end
