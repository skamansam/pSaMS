module PluginLoader

  def self.included(base)
    logger.info "#{base} is a PluginLoader"
    base.extend ClassMethods
  end

  def self.registered(base)
    logger.info "#{base} is a PluginLoader"
    base.extend ClassMethods
  end

  module ClassMethods
    def load_plugins(path,run_migrations)
      logger.info "Loading Plugins..."
      process_files(path) do |filename, classname|
        logger.info "Initializing plugin #{classname} in #{filename}"
        if run_migrations && const_get(classname).present?
          logger.info "Running Migrations for #{classname}..."
          classname.constantize.try(:migrate)
        else
          if classname.to_s.instance_of?(Module)
            logger.info "Loading  #{classname} from #{filename}..."
            include cname.constantize
          else
            logger.info "Creating new #{classname} from #{filename}..."
            classname.constantize.setup
          end
        end
      end
    end

    def clean_plugins!
      Padrino.reload!
      Plugin.all.each do |plugin|
        plugin_class = nil
        plugin.active = false unless is_loaded?(plugin.class_name)
        begin
          plugin_class = plugin.class_name.constantize
          plugin.active = false unless plugin_class.new.respond_to?(plugin.method_name)
          plugin.name = plugin_class.name
        rescue NameError=>e
          ErrorHandler.add_error plugin.file_name, e
        end
        plugin.save
      end
    end


    private

    def process_files(dir,&block)
      Dir.glob(Padrino.root("#{dir}/*")) do |file|
        reload_plugin(file, &block)
      end
    end

    def is_loaded?(class_name)
      begin
        Module.const_get(class_name)
        return true
      rescue NameError
        return false
      end
    end

    def reload_plugin(path, force=false)
      logger.info "looking in #{path}"
      path = "#{path}/#{File.basename(path)}.rb" if File.directory?(path)

      if File.basename(path) =~ /(.*)\.rb$/
        logger.info "Found class #{$1.camelize}"
        cname = $1.camelize
      end
      return if (self.is_a?(Class) && is_loaded?(cname)) && !force #already loaded
      if set_load_paths(path)
        yield path, '::'+cname if block_given?
        true
      end
      false
    end

    def set_load_paths(path)
      begin
        Padrino.load_paths << path
        Padrino.dependency_paths << path
        Padrino.require_dependencies(path)
        true
      rescue Exception => err
        Padrino.load_paths.delete path
        Padrino.dependency_paths.delete path
        ErrorHandler::add_error(path, err)
        false
      end
    end
  end
end
