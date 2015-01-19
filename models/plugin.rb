# == Schema Information
#
# Table name: plugins
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  priority    :integer
#  plugin_type :string(255)
#  file_name   :string(255)
#  line_number :integer
#  class_name  :string(255)
#  method_name :string(255)
#  hook_name   :string(255)
#  num_args    :integer
#  options     :text
#  active      :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  context     :string(255)      default("*")
#

# The Plugin class holds information about a plugin and allows other objects
# to call plugin methods
class Plugin < ActiveRecord::Base
  include ErrorHandler
  include PluginLoader
  include Filter
  include Filter::Publisher
  include Action
  include Action::Publisher

  load_plugins('plugins', ENV['MIGRATIONS'])

  validates :plugin_type, :method_name, :class_name, :hook_name, presence: true

  serialize :options, Hash
  serialize :features, Array

  def self.active
    where(active: true)
  end

  def activate!
    update_attributes(active: true)
  end

  def self.inactive
    where(active: false)
  end

  def deactivate!
    update_attributes(active: false)
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

  def self.with_context(context)
    where(context: context)
  end

  def self.by_priority
    by_install_date.order(:priority)
  end

  def self.reload_plugins!
    clean_plugins!
    load_plugins('plugins', ENV['MIGRATIONS'])
  end

  def plugin_object
    @plugin_object ||= class_name.constantize
  end

  def actions
    Plugin.where(class_name: class_name)
  end

  def info
    plugin_object.info
  end

end
