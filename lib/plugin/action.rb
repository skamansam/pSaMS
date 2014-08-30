module Action
  # for WP HOOKS, see the Wordpress dox
  HOOKS = {
    :muplugins_loaded => "After must-use plugins are loaded. no params.",
    :registered_taxonomy => "After adding a new tag or category. passes taxonomy, object_type, args",
    :plugins_loaded => "",
    :after_setup_theme => "",
    :head => "Included in <head> of each page",
    :body => "Included in top of body of each page",
    :footer => "Included in top of body of each page",
    :js => "Included at end of body of each page, in the javascript includes. Is wrapped in a javascript tag, so must be javascript string",
    :js_file => "Included at end of body of each page, in the javascript includes. Included using a JS include tag",
    :css => "Included in <head> of each page, in CSS section. Must be valid CSS",
    :css_file => "Included in <head> of each page, in CSS section. Must be a path to a file."
  }

  def self.included(base)
    logger.info "#{self} included in #{base}"
    base.extend ClassMethods
    #base.extend PluginBase
  end
  module ClassMethods
    def actions
      where(plugin_type: ['Action','action']).active
    end
    def add_action(action_name,action_context,class_name,method_name,priority=10,num_args=nil)
      logger.info "Registering (#{self} #{class_name}) Action for #{action_name} in #{action_context}: #{class_name}.#{method_name}(#{num_args}) at priority #{priority}"
      plugins = Plugin.where(class_name: class_name, context: action_context, hook_name: action_name, method_name: method_name, plugin_type: ['Action','action'])
      unless plugins.first
        file,line = class_name.constantize.new.method(method_name).source_location
        name,description = class_name.constantize.info
        action_context ||= '*'
        plugin = Plugin.create!(class_name: class_name, hook_name: action_name, name: name,
                             method_name: method_name, file_name: file, context: action_context,
                             line_number: line, priority: priority, num_args: num_args, plugin_type: 'Action')
      end
    end
  end
end

module Action::Publisher
  def self.included(base)
    logger.info "#{self} included in #{base}"
    base.extend PublisherMethods
  end
  module PublisherMethods
    def apply_action(hook_name,context='*',*data)
      data = ''
      return data if (actions = Plugin.actions.by_priority.for_hook(hook_name).with_context(context)).blank?
      actions.each do |action|
        puts "Applying action #{action.hook_name} for #{context} with #{data.inspect}"
        the_obj = action.class_name.constantize.new
        data = the_obj.send(action.method_name, *data)
      end
      data
    end
  end
end

=begin
  # registers action with pSaMS. Necessary to use plugin. Fails if function name is already registered.
  # @param hook_name the name of the hook. see Hooks.md for a list of known hooks.
  # @param function_name the name of the function to call, executed within the scope of your plugin.
  # @param class_name the class or name of the class you are registering.
  # @param priority the priority of the function. starts at 0 for higher priority. default is 10
  # @param num_function_args [WP compat] the number of arguments your function can handle. Used because some hooks can pass more than one value.
  # @returns function name or false if the function name has already been registered
  def add_action(hook_name,function_name,class_name = nil, priority = 10, num_function_args=1)
    class_name = class_name.to_s
    return false if action_exists?(hook_name,function_name,class_name = nil, priority = 10)
    event_table[class_name] = {} unless event_table[class_name].present?
    event_table[class_name].deep_merge!( { hook_name => { priority => [] } } )
    event_table[class_name][hook_name][priority] << function_name
  end

  # simply replaces the table of actions with a new one, destructively
  # @param new_event_table the hash of new actions, in the form: { hook_name => {priority_int => [function1, function2, ...] } }
  def add_actions!(new_event_table,class_name)
    event_table[class_name] = new_event_table
  end


  private

  def action_exists?(hook_name,function_name,class_name = nil, priority = 10, num_function_args=1)
    ( event_table.try(class_name).try(hook_name).try(priority) || [] ).include?(function_name)
  end
  alias :action_exist? :action_exists?

=end


