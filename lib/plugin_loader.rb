# PluginLoader handles the loading and unloading of pSaMS plugins
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
    def load_plugins(path, run_migrations)
      logger.info "Loading Plugins..."
      process_files(path) do |filename, classname|
        logger.info "Initializing plugin #{classname} in #{filename}"
        if run_migrations && const_get(classname).present?
          logger.info "Running Migrations for #{classname}..."
          classname.constantize.try(:migrate)
        else
          if classname.to_s.instance_of?(Module)
            logger.info "Loading  #{classname} from #{filename}..."
            begin
              include cname.constantize
            rescue StandardError => err
              logger.info "ERROR: Cannot load  #{classname}: #{err}"
            rescue Exception => err
              logger.info "ERROR: Cannot load  #{classname}: #{err}"
            end
          else
            logger.info "Creating new #{classname} from #{filename}..."
            classname.constantize.try(:setup)
          end
        end
      end
    end

    def clean_plugins!
      #Padrino.reload!
      Plugin.all.each do |plugin|
        plugin_class = nil
        plugin.active = false unless loaded?(plugin.class_name)
        begin
          plugin_class = plugin.class_name.constantize
          plugin.active = false unless plugin_class.new.respond_to?(plugin.method_name)
          plugin.name = plugin_class.name
        rescue NameError => e
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

    def loaded?(class_name)
      Module.const_get(class_name)
      return true
    rescue NameError
      return false
    end

    def reload_plugin(path, force=false)
      logger.info "looking in #{path}"
      path = "#{path}/#{File.basename(path)}.rb" if File.directory?(path)

      if File.basename(path) =~ /(.*)\.rb$/
        logger.info "Found class #{Regexp.last_match[1].camelize}"
        cname = Regexp.last_match[1].camelize
      end
      return if (self.is_a?(Class) && loaded?(cname)) && !force # already loaded
      if set_load_paths(path)
        yield path, '::' + cname if block_given?
        true
      end
      false
    end

    def set_load_paths(path)
      Padrino.require_dependencies(path)
      $LOAD_PATH.concat([path]) unless $LOAD_PATH.include?(path)
      true
    rescue Exception => err
      logger.error "There was a catastrophic error in #{path}.\n\t#{err.message}"
      Padrino.dependency_paths.delete path
      ErrorHandler.add_error(path, err)
      false
    rescue StandardError => err
      logger.error "There was an error in #{path}. #{err.message}"
      Padrino.dependency_paths.delete path
      ErrorHandler.add_error(path, err)
      false
    end
  end
end
