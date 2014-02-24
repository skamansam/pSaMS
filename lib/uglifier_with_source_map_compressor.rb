require 'sprockets'
class UglifierWithSourceMapCompressor
  attr_reader :data
  attr_reader :file
  
  def initialize(file, &block)
    @file = file
    @data = block.call
  end
  
  def self.default_mime_type
    'application/javascript'
  end
  
  def render(context,options)
    require 'uglifier' unless defined? ::Uglifier
    puts "Padrino #{Padrino.root rescue []}"
    puts "Compressing #{@file.inspect}"
    
    minified  = ''
    sourcemap = ''
    js_file = File.basename @file
    
    # Feature detect Uglifier 2.0 option support
    if Uglifier::DEFAULTS[:copyright]
      # Uglifier < 2.x
      minified, sourcemap = Uglifier.new(copyright: false).compile_with_map(data)
    else
      # Uglifier >= 2.x
      minified, sourcemap = Uglifier.new(comments: :none).compile_with_map(data)
    end

    # write the sourcemap to a file somewhere under public
    FileUtils.mkdir_p(Padrino.root('public','js_maps'))
    sourcemap_path = Padrino.root('public','js_maps',js_file+'.map')
    puts "saving map to #{sourcemap_path}"
    File.truncate(sourcemap_path,0) if File.exists?(sourcemap_path)
    size = IO.write sourcemap_path, sourcemap
    puts "source map size: #{size}"
    sourcemap_comment = "//@ sourceMappingURL=/js_maps/#{js_file}.map\n"

    return minified + sourcemap_comment
  end
end

