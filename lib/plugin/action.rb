module Action
  attr_reader :action_table # hash in the form ClassName => 'hook_name' => priority_int => [fxn1, fxn2,...]
  
  # for HOOKS, see the Wordpress dox
  HOOKS = {
    :muplugins_loaded => "After must-use plugins are loaded. no params.",
    :registered_taxonomy => "After adding a new tag or category. passes taxonomy, object_type, args",
    :plugins_loaded => "",
    :after_setup_theme => "",
  }

  def self.included(base)
    #base.send(:include, AssetTagHelpers)
    #base.extend ClassMethods
  end


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


end

