class FilterPlugin < Plugin
  default_scope { where(type: 'Filter') }

  def self.add_filter(hook_name,class_name,method_name,priority=10,num_args=nil, opts = {})
    puts "Registering (#{self} #{self.class}) Filter for #{hook_name}: #{class_name}.#{method_name}(#{num_args}) at priority #{priority}"
    puts "filter_table: #{filter_table.inspect}"

    plugins = FilterPlugin.where(class_name: class_name, hook: hook_name, method_name: method_name, type: 'Filter')
    unless plugins.first
      file,line = class_name.constantize.new.method(method_name).source_location
      plugin = FilterPlugin.create!(class_name: class_name, hook: hook_name, class_name: class_name, 
                           method_name: method_name, file_name: file, 
                           line_number: line, priority: priority, num_args: num_args)
    end
  end

  def self.apply_filter(hook_name,*data)
    return data[0] if (plugins = Plugin.for_hook(hook_name).by_priority).blank?
    plugins.each do |filter|
      puts "Applying filter #{filter.hook_name} with #{data.inspect}"
      the_obj = filter.class_name.constantize
      the_obj = the_obj.new if the_obj.respond_to?(:new)
      data = the_obj.call(filter.method_name,data) || data[0]
    end
    data
  end

end
