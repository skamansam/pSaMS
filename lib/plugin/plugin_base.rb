module PluginBase
  def self.included(base)
    logger.info "#{self} included in #{base}"
    base.extend ClassMethods
  end
  module ClassMethods
    def add_plugin_method(method_type,action_name,class_name,method_name,priority=10,num_args=nil)
      puts "Registering (#{self} #{self.class}) #{method_type} for #{hook_name}: #{class_name}.#{method_name}(#{num_args}) at priority #{priority}"
      plugins = Plugin.where(class_name: class_name, hook_name: hook_name, class_name: class_name, method_name: method_name, plugin_type: method_type)
      unless plugins.first
        file,line = class_name.constantize.new.method(method_name).source_location
        name,description = class_name.constantize.info
        plugin = Plugin.create!(class_name: class_name, hook_name: hook_name, name: name, 
                             method_name: method_name, file_name: file, 
                             line_number: line, priority: priority, num_args: num_args, plugin_type: method_type)
      end
    end

    def call_plugin_method(method_type,hook_name,*data)
      return data[0] if (plugin_methods = Plugin.by_priority.for_hook(hook_name).where(plugin_type: method_type)).blank?
      plugin_methods.each do |plugin_method|
        puts "Applying #{method_type} #{plugin_method.hook_name} with #{data.inspect}"
        the_obj = plugin_method.class_name.constantize.new
        data = the_obj.send(plugin_method.method_name, *data) || data[0]
      end
      data
    end
  end
end
