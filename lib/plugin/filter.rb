module Plugin::Filter
  attr_reader :filter_table # hash in the form 'hook_name' => [{ClassName => [fxn1, fxn2,...], ClassName => [fx1,fx2]}]. index is priority

  def self.included(base)
    puts "#{base} included"
    #base.send(:include, AssetTagHelpers)
    #base.extend ClassMethods
  end


  def has_filter()
  end

  # appends the filter to the list of filters.
  # @return the array of existing filters for the given hook at the given priority
  def add_filter(hook_name,class_name,method_name,priority=10,num_args=nil)
    puts "Registering Filter for #{hook_name}: #{class_name}.#{method_name}(#{num_args}) at priority #{priority}"
    arr = filter_table[hook_name] || []
    if filter_table[hook_name][priority].keys.include?(class_name)
      filter_table[hook_name][priority][class_name] << method_name
    else
      filter_table[hook_name][priority] = {} unless filter_table[hook_name][priority].present?
      filter_table[hook_name][priority][class_name] = [method_name]
    end
    filter_table[hook_name][class_name]
  end
  alias :register_filter :add_filter
  def apply_filter(for_hook_name,*data)
    filter_table.each do |class_name, hook_data|
      hook_data.each do |hook_name,method_data|
        next unless hook_name == for_hook_name
        method_data.keys.sort.each do |priority|
          the_obj = class_name.constantize.new
          method_data[priority].each do |method_name|
            the_obj.call(method_name,*data)
          end
        end
      end
    end
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
