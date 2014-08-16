module Filter
  # add class methods for subscriber by default
  def self.included(base)
    logger.info "#{self} included in #{base}"
    base.extend ClassMethods
  end
  module ClassMethods
    def filters
      where(plugin_type: ['Filter','filter'])
    end
    def add_filter(hook_name,class_name,method_name,priority=10,num_args=nil)
      puts "Registering (#{self} #{self.class}) Filter for #{hook_name}: #{class_name}.#{method_name}(#{num_args}) at priority #{priority}"
      plugins = Plugin.where(class_name: class_name, hook_name: hook_name, class_name: class_name, method_name: method_name, plugin_type: 'Filter')
      unless plugins.first
        file,line = class_name.constantize.new.method(method_name).source_location
        name,description = class_name.constantize.info
        plugin = Plugin.create!(class_name: class_name, hook_name: hook_name, name: name, 
                             method_name: method_name, file_name: file, 
                             line_number: line, priority: priority, num_args: num_args, plugin_type: 'Filter')
      end
    end
  end
end

module Filter::Publisher
  def self.included(base)
    logger.info "#{self} included in #{base}"
    base.extend PublisherMethods
  end
  module PublisherMethods
    def apply_filter(hook_name,*data)
      return data[0] if (filters = Plugin.filters.by_priority.for_hook(hook_name)).blank?
      binding.pry
      filters.each do |filter|
        puts "Applying filter #{filter.hook_name} with #{data.inspect}"
        the_obj = filter.class_name.constantize.new
        data = the_obj.send(filter.method_name, *data) || data[0]
      end
      data
    end
  end
end

=begin
module Filter::Publisher::PublisherMethods
end
module Filter::ClassMethods

  # appends the filter to the list of filters.
  # @return the array of existing filters for the given hook at the given priority
  def add_filter(hook_name,class_name,method_name,priority=10,num_args=nil)
    #Filter::filter_table = {} if PSaMs::App.filter_table.blank?
    filter_table = Filter::filter_table
    puts "Registering (#{self} #{self.class}) Filter for #{hook_name}: #{class_name}.#{method_name}(#{num_args}) at priority #{priority}"
    puts "filter_table: #{filter_table.inspect}"
    arr = filter_table[hook_name] || []
    if arr[priority] && arr[priority].keys.include?(class_name)
      arr[priority][class_name] << method_name
    else
      arr[priority] = {} unless arr[priority].present?
      arr[priority][class_name] = [method_name]
    end
    filter_table[hook_name] = arr
    #self.class_variable_set "@@filter_table",arr 
    Filter::filter_table = filter_table
    #binding.pry
  end
  alias :register_filter :add_filter

  def has_filter()
  end


  def apply_filters_ref_array()
  end
  def remove_filter()
  end
  def remove_all_filters()
  end
  def doing_filter()
  end
  def register_activation_hook()
  end
  def register_uninstall_hook()
  end

  private
  def add_with_priority(class_name,method_name, priority)

  end
end
=end
