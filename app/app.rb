require 'sinatra/base'
module PSaMs
  class App < Padrino::Application
    register WillPaginate::Sinatra
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    register Padrino::Sprockets
    sprockets
    enable :sessions
    
    
    ##
    # Caching support.
    #
    #register Padrino::Cache
    #enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache.new(:Memcached, :server=>'127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Dalli, :server=>'127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Redis, :server=>'127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Memory)
    # set :cache, Padrino::Cache.new(:File)
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #
    #layout :application

    ##
    # You can configure for a specified environment like:
    #
    configure :development do
      set :server, :thin
      disable :asset_stamp # no asset timestamping for dev
      #sprockets #:minify=>true , :js_compressor => UglifierWithSourceMapCompressor do |env| #, :css_compressor=>:yui
      #  puts "Configure: #{env.inspect}" 
      #  env.css_compressor = :yui
      #end
    end
    configure :production do
      set :run,false
      disable :asset_stamp # no asset timestamping for dev
      #sprockets :minify=>true
    end
    #

    ##
    # You can manage errors like:
    #
    #error 404 do
    #  title = request.path_info.split('/')[-1]
    #  logger.info "Requestind #{title}"
    #  if @post = Post.find_by_path(title)
    #    redirect url_for(:posts, :show, id: @post.id)
    #  else  
    #    #render '/__sinatra__/404.png'
    #  end
    #end
    #
    #   error 505 do
    #     render 'errors/505'
    #   end
    #
    get "/" do
      content_for(:page_title, "Home")
      load_category
      @posts = Post.without_news.all

      render "welcome/index",:layout=>'application'
    end
        
  end
end
