# This file contains monkey patches to get things working properly
# sprockets overrides some things, so we need this right after Padrino::Rendering

PSaMs::Admin.class_eval do

end

Padrino::Rendering::InstanceMethods.class_eval do
=begin
  ##
  # Enhancing Sinatra render functionality for:
  #
  # * Using layout similar to rails
  # * Use render 'path/to/my/template'   (without symbols)
  # * Use render 'path/to/my/template'   (with engine lookup)
  # * Use render 'path/to/template.haml' (with explicit engine lookup)
  # * Use render 'path/to/template', :layout => false
  # * Use render 'path/to/template', :layout => false, :engine => 'haml'
  #
  def render(engine, data=nil, options={}, locals={}, &block)

    # If engine is nil, ignore engine parameter and shift up all arguments
    # render nil, "index", { :layout => true }, { :localvar => "foo" }
    engine, data, options = data, options, locals if engine.nil? && data

    # Data is a hash of options when no engine isn't explicit
    # render "index", { :layout => true }, { :localvar => "foo" }
    # Data is options, and options is locals in this case
    data, options, locals = nil, data, options if data.is_a?(Hash)

    # If data is unassigned then this is a likely a template to be resolved
    # This means that no engine was explicitly defined
    data, engine = resolve_template(engine, options) if data.nil?

    # Cleanup the template.
    @current_engine, engine_was = engine, @current_engine
    @_out_buf,  buf_was = ActiveSupport::SafeBuffer.new, @_out_buf

    # Pass arguments to Sinatra render method.
    super(engine, data, with_layout(options), locals, &block)
  ensure
    @current_engine = engine_was
    @_out_buf = buf_was
  end
=end
  def resolve_layout(layout, options={})
    layouts_path = options[:layout_options] && options[:layout_options][:views] || options[:views] || settings.views || "./views"
    template_path = settings.fetch_layout_path(layout, layouts_path)
    rendering_options = [template_path, content_type || :html, locale]
    layouts_path = [layouts_path].flatten
    settings.cache_template_path(rendering_options) do
      selected_template = nil
      layouts_path.each do |path|
        template_candidates = glob_templates(path, template_path)
        break if selected_template = select_template(template_candidates, *rendering_options)
      end

      fail TemplateNotFound, "Layout '#{template_path}' not found in '#{layouts_path}'" if !selected_template && layout.present?
      selected_template
    end
  end
  private
  def resolve_template(template_path, options={})
    template_path = template_path.to_s
    template_path = File.absolute_path(template_path) if template_path=~/^\/?.?.?\//
    controller_key = respond_to?(:request) && request.respond_to?(:controller) && request.controller
    rendering_options = [template_path, content_type || :html, locale]
    options = Padrino::Rendering::DEFAULT_RENDERING_OPTIONS.merge(options)

    settings.cache_template_path(["#{controller_key}/#{template_path}", rendering_options[1], rendering_options[2]]) do
      view_dirs = [options[:views],settings.views,"./views"].flatten.compact.uniq.map{|p| File.absolute_path(p)}
      selected_template = nil
      view_dirs.each do |view_dir|
        template_candidates = glob_templates(view_dir, template_path)
        selected_template = select_template(template_candidates, *rendering_options)
        selected_template ||= template_candidates.first unless options[:strict_format]
        break if selected_template
      end
      fail(Padrino::Rendering::TemplateNotFound, "Template '#{template_path}' not found in '#{view_dirs}'")  if !selected_template && options[:raise_exceptions]
      selected_template
    end
  end
  ##
  # Returns the cached layout path.
  #
  # @param [String, nil] given_layout
  #   The requested layout.
  # @param [String, nil] layouts_path
  #   The directory where the layouts are located. Defaults to #views.
  #
  def fetch_layout_path(given_layout, layouts_path=views)
    layout_name = (given_layout || @layout || :application).to_s
    cache_layout_path(layout_name) do
      if layouts_path.is_a?(Array)
        layouts_path.each{ |layout_path| return layout_name if Dir["#{layout_path}/#{layout_name}.*"].any?}
      elsif Pathname.new(layout_name).absolute? && Dir["#{layout_name}.*"].any? || Dir["#{layouts_path}/#{layout_name}.*"].any?
        layout_name
      else
        File.join('layouts', layout_name)
      end
    end
  end

end

Sinatra::Templates.module_eval do
  # File 'lib/sinatra/base.rb', line 760
  def find_template(views, name, engine)
    views = [views].flatten
    yield locate_file(views, name, @preferred_extension)
    Tilt.mappings.each do |ext, engines|
      next unless ext != @preferred_extension && engines.include?(engine)
      yield locate_file(views, name, ext)
    end
  end

  def locate_file(paths, file, preferred_extension)
    file = file.to_s
    paths = [paths].flatten
    paths.each do |path|
      next unless File.directory?(path)
      path = File.absolute_path(File.join(path, file))
      if File.exist?(path)
        return path
      elsif File.exist?("#{path}.#{preferred_extension}")
        return "#{path}.#{preferred_extension}"
      else
        possible_files = Dir.glob(path + '.*')
        return possible_files.first if possible_files.size > 0
      end
    end
  end

=begin

  def render(engine, data, options = {}, locals = {}, &block)
    # merge app-level options
    engine_options  = settings.respond_to?(engine) ? settings.send(engine) : {}
    options.merge!(engine_options) { |key, v1, v2| v1 }

    # extract generic options
    locals          = options.delete(:locals) || locals         || {}
    views           = options.delete(:views)  || settings.views || "./views"
    layout          = options[:layout]
    layout          = false if layout.nil? && options.include?(:layout)
    eat_errors      = layout.nil?
    layout          = engine_options[:layout] if layout.nil? or (layout == true && engine_options[:layout] != false)
    layout          = @default_layout         if layout.nil? or layout == true
    layout_options  = options.delete(:layout_options) || {}
    content_type    = options.delete(:content_type)   || options.delete(:default_content_type)
    layout_engine   = options.delete(:layout_engine)  || engine
    scope           = options.delete(:scope)          || self
    options.delete(:layout)

    # set some defaults
    options[:outvar]           ||= '@_out_buf'
    options[:default_encoding] ||= settings.default_encoding

    # compile and render template
    begin
      layout_was      = @default_layout
      @default_layout = false
      template        = compile_template(engine, data, options, views)
      output          = template.render(scope, locals, &block)
    ensure
      @default_layout = layout_was
    end

    # render layout
    if layout
      options = options.merge(:views => views, :layout => false, :eat_errors => eat_errors, :scope => scope).
              merge!(layout_options)
      catch(:layout_missing) { return render(layout_engine, layout, options, locals) { output } }
    end

    output.extend(ContentTyped).content_type = content_type if content_type
    output
  end

  def compile_template(engine, data, options, views)
    eat_errors = options.delete :eat_errors
    template_cache.fetch engine, data, options, views do
      template = Tilt[engine]
      raise "Template engine not found: #{engine}" if template.nil?

      case data
      when Symbol
        body, path, line = settings.templates[data]
        if body
          body = body.call if body.respond_to?(:call)
          template.new(path, line.to_i, options) { body }
        else
          found = false
          @preferred_extension = engine.to_s
          find_template(views, data, template) do |file|
            path ||= file # keep the initial path rather than the last one
            if found = File.exist?(file)
              path = file
              break
            end
          end
          throw :layout_missing if not found
          template.new(path, 1, options)
        end
      when Proc, String
        body = data.is_a?(String) ? Proc.new { data } : data
        path, line = settings.caller_locations.first
        template.new(path, line.to_i, options, &body)
      else
        raise ArgumentError, "Sorry, don't know how to render #{data.inspect}."
      end
    end
  end
=end
end
