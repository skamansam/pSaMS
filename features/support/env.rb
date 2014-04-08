RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

require 'capybara/cucumber'
require 'rspec/expectations'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'forgery'
require 'factory_girl'

FactoryGirl.definition_file_paths =[]
Dir[File.join(Padrino.root,'spec','factories','**','*.rb')].each {|f| FactoryGirl.definition_file_paths << f.sub(/.rb$/,'')}
FactoryGirl.find_definitions

World(FactoryGirl::Syntax::Methods)

DatabaseCleaner.strategy = :truncation

Before do
  DatabaseCleaner.start
end

After do |scenario|
  DatabaseCleaner.clean
end

##
# You can handle all padrino applications using instead:
#   Padrino.application
Capybara.app = Padrino.application #PSaMs::App.tap { |app|  }
