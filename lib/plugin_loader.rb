module PluginLoader

  def self.included(base)
    logger.info "PluginLoader included in #{base}"
    base.extend ClassMethods
  end
  def self.registered(base)
    logger.info "PluginLoader registered to #{base}"
    #base.send :attr_reader, :page_refs
    base.extend ClassMethods
  end
  module ClassMethods
    attr_accessor :pages_list, :plugin_list
    def load_plugins(path,run_migrations)
      logger.info "Loading Plugins..."
      process_files(path) do |filename, classname|
        if run_migrations && const_get(classname).present?
          classname.constantize.try(:migrate)
        else
          if classname.to_s.instance_of?(Module)
            logger.info "Loading  #{classname} from #{filename}..."
            include cname.constantize
          else
            logger.info "Creating new #{classname} from #{filename}..."
            #binding.pry
            classname.constantize.setup
          end
        end
      end
    end

    private

    def process_files(dir,&block)
      Dir.glob(Padrino.root("#{dir}/*")) do |file|
        logger.info "looking in #{file}"

        file = "#{file}/#{File.basename(file)}.rb" if File.directory?(file)

        if File.basename(file) =~ /(.*)\.rb$/
          logger.info "Found class #{$1.camelize}"
          cname = $1.camelize
        end
        Padrino.load_paths << file
        Padrino.dependency_paths << file
        Padrino.require_dependencies(file)
        require file

        yield file, cname
      end
    end

  end
end

