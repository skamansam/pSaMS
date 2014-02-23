# Helper methods defined here can be accessed in any controller or view in the application

PSaMs::App.helpers do
  #include Sinatra::AssetPack::Helpers
  #include Sprockets::Helpers
  #method to set the theme. returns the layout.

  def set_theme
    Padrino.logger.info "Setting theme"
    theme = params[:theme] || 'default'
    theme_path = '/views/layouts/theme/'+theme
    #Padrino::Pipeline.configure_assets do |config|
    #  config.css_assets = [config.css_assets] + [theme_path+'/stylesheets']
    #  config.js_assets = [config.js_assets] + [theme_path+'/javascripts']
    #  config.image_assets = [config.image_assets] + [theme_path+'/images']
    #end
    #layout theme
    return theme.to_sym
  end

  def theme_partial_path
    '/layouts/theme/'+(params[:theme] || 'default')
  end
  def theme_asset_path
    'theme/'+(params[:theme] || 'default')
  end

  def js(file, options={})
    javascript_include_tag "/assets/#{file}", (options || {})
  end
  def css(file,options = {})
    stylesheet_link_tag "/assets/#{file}", (options || {})
  end
  def image(file,options={})
    image_tag "/assets/#{file}", (options || {})
  end


  def theme_js(file,options={})
    javascript_include_tag "/assets/#{theme_asset_path}/#{file}", options
  end
  def theme_css(file,options={})
    stylesheet_link_tag "/assets/#{theme_asset_path}/#{file}", options
  end
  def theme_image(file,options={})
    image_tag "/assets/#{theme_asset_path}/#{file}", options
  end


end
