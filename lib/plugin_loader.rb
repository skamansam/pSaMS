module PluginLoader
  #include Action
  #include Filter::Publisher
  #include Editor
  #include Page
  
  #attr_reader :page_refs

  def self.registered(base)
    puts "PluginManager registered to #{base}"
    #base.send :attr_reader, :page_refs
    base.extend ClassMethods
  end
  module ClassMethods
    #attr_accessor :page_refs, :filter_table
    def load_plugins
      logger.info "Loading Plugins..."
      Dir.glob("lib/plugins/*") do |file| 
        if File.directory?(file)
          puts File.basename(file).camelize
        elsif file=~/\.rb$/

      end
    end
  end
end

