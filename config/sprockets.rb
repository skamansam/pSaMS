module Padrino::Sprockets
  def self.registered(base)
    base.set :sprockets, ::Sprockets::Environment.new(Padrino.root)

    # Add folder
    base.sprockets.append_path 'assets/javascripts'
    base.sprockets.append_path 'assets/stylesheets'
    base.sprockets.append_path 'assets/images'
    base.set :digest_assets, true

    # compress file
    if PADRINO_ENV == 'development'
      base.sprockets.js_compressor = Uglifier.new(mangle: true)
      base.sprockets.css_compressor = YUI::CssCompressor.new
    end

    # sprockets-helpers
    base.helpers Sprockets::Helpers
    # We can configure `sprockets-helpers` to find the correct assets for us.
    Sprockets::Helpers.configure do |config|
      manifest_path      = File.join(Padrino.root,'public','assets','manifest.json')
      config.environment = base.sprockets
      config.prefix      = '/assets'
      config.manifest    = Sprockets::Manifest.new(base.sprockets, manifest_path)
      config.digest      = false
      config.public_path = base.public_folder
      config.debug       = true #if development?
    end

    # call sprockets :D
    if PADRINO_ENV == 'development'
      base.get '/assets/*splat' do
        env['PATH_INFO'].gsub!(%r{\A/?assets}, '')
        settings.sprockets.call(env)
      end
    end
  end
end
