RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
#require 'forgery'
#require 'factory_girl'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  #conf.include Forgery
end

#Dir[File.join(Padrino.root,'spec','factories','**','*.rb')].each {|f| FactoryGirl.definition_file_paths << f.sub(/.rb$/,'')}

#FactoryGirl.definition_file_paths.uniq!
#FactoryGirl.definition_file_paths = [
#    File.join(Padrino.root, 'factories'),
#    File.join(Padrino.root, 'test', 'factories'),
#    File.join(Padrino.root, 'spec', 'factories')
#]
#puts FactoryGirl.definition_file_paths #FactoryGirl.factories
#puts FactoryGirl.definitions
#FactoryGirl.find_definitions

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app PSaMS::App
#   app PSaMS::App.tap { |a| }
#   app(PSaMS::App) do
#     set :foo, :bar
#   end
#
#FactoryGirl.definition_file_paths = [
#    File.join(Padrino.root, 'factories'),
#    File.join(Padrino.root, 'test', 'factories'),
#    File.join(Padrino.root, 'spec', 'factories')
#]
#FactoryGirl.find_definitions

def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end


