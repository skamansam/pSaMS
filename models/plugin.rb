# The Plugin class holds information about a plugin and allows other objects
# to call plugin methods
class Plugin < ActiveRecord::Base
  include PluginLoader
  include Filter
  include Filter::Publisher

  load_plugins('plugins')
  validate :plugin_type, :method_name, :class_name, :hook_name, presence: true
  
  serialize :options, Hash
  serialize :features, Array

  def self.active
    where(active: true)
  end

  def self.inactive
    where(active: false)
  end

  def self.by_install_date
    order(:created_at)
  end
  
  def self.by_last_updated
    order(:modified_at)
  end

  def self.for_hook(hook)
    where(hook_name: hook)
  end

  def self.by_priority
    by_install_date.order(:priority)
  end

  def plugin_object
    @plugin_object ||= class_name.constantize
  end

  def info
    plugin_object.info
  end

  def actions
    Plugin.where(class_name: class_name)
  end
end
