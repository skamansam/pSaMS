RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require 'forgery'
require 'factory_girl'

RSpec.configure do |conf|
  #conf.include Rack::Test::Methods
  #conf.include Forgery
end

FactoryGirl.definition_file_paths = [
    File.join(Padrino.root, 'factories'),
    File.join(Padrino.root, 'test', 'factories'),
    File.join(Padrino.root, 'spec', 'factories')
]
FactoryGirl.find_definitions

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app PSaMS::App
#   app PSaMS::App.tap { |a| }
#   app(PSaMS::App) do
#     set :foo, :bar
#   end
#

def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end
