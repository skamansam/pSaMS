# == Schema Information
#
# Table name: plugins
#
#  id          :integer          not null, primary key
#  name        :string
#  priority    :integer
#  plugin_type :string
#  file_name   :string
#  line_number :integer
#  class_name  :string
#  method_name :string
#  hook_name   :string
#  num_args    :integer
#  options     :text
#  active      :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  context     :string           default("*")
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
  rescue NameError => e
      ErrorHandler.add_error class_name, e 
      return false
  end

  def actions
    Plugin.where(class_name: class_name)
  end

  def class_method(sym, *args, &block)
    begin
      self.class_name.constantize.send(sym,args,block)
    catch(e)
      throw MethodMissingError
    end
  end

  def call_method(sym, *args, &block)
    begin
      self.class_name.constantize.new.send(sym,args,block)
    catch(e)
      throw MethodMissingError
    end
  end

end
