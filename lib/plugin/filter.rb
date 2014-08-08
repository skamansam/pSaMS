module Filter
  # add class methods for subscriber by default
  def self.included(base)
    puts "#{self} included in #{base}"
    base.extend ClassMethods
  end
  module ClassMethods
    def add_filter(hook_name,class_name,method_name,priority=10,num_args=nil)
      puts "Registering (#{self} #{self.class}) Filter for #{hook_name}: #{class_name}.#{method_name}(#{num_args}) at priority #{priority}"
      puts "filter_table: #{filter_table.inspect}"
      plugins = Plugin.where(class_name: class_name, hook: hook_name, class_name: class_name, method_name: method_name, type: 'Filter')
      unless plugins.first
        file,line = class_name.constantize.new.method(method_name).source_location
        plugin = Plugin::Filter.create(class_name: class_name, hook: hook_name, class_name: class_name, 
                             method_name: method_name, file_name: file, 
                             line_number: line, priority: priority, num_args: num_args)
      end
    end
  end
end

module Filter::Publisher
  def self.included(base)
    puts "#{self} included in #{base}"
    base.extend PublisherMethods
  end
  module PublisherMethods
    def apply_filter(hook_name,*data)

      return data[0] unless plugins = Plugin.for_hook(hook_name)
      plugins.each.each_with_index do |hook_data,priority|
        puts "Applying filter #{hook_name} with #{data.inspect}"
        hook_data.each do |hook_name,method_data|
          method_data.each do |class_name, methods|
            the_obj = class_name.constantize.new
            methods.each do |method_name|
              data = the_obj.call(method_name,data) || data[0]
            end
          end
        end
      end
      data
    end
  end
end

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

