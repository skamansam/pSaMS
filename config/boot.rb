# Defines our constants
RACK_ENV = PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

##
# ## Enable devel logging
#
Padrino::Logger::Config[:development][:log_level]  = :devel
Padrino::Logger::Config[:development][:log_static] = true
#
# ## Configure your I18n
#
I18n.default_locale = :en
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

# uncomment if you get TypeErrors. it may be carrierwave
#CarrierWave.root = File.join(Padrino.root, "public")

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
  require 'will_paginate'
  require 'will_paginate/active_record'
  require 'will_paginate/view_helpers/sinatra'

  #require 'actionview'
  include WillPaginate::Sinatra::Helpers
  ['app','admin'].each do |app|
    presenters_path = Padrino.root(app,'presenters','**','*.rb')
    interactors_path = Padrino.root(app,'interactors','**','*.rb')
    Padrino.dependency_paths << presenters_path unless Padrino.dependency_paths.include?(presenters_path)
    Padrino.dependency_paths << interactors_path unless Padrino.dependency_paths.include?(interactors_path)
  end
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
  #require File.dirname(__FILE__)+'/../patches/application.rb'
end

# Setup better_errors
=begin
if Padrino.env == :development
  require 'better_errors'
  Padrino::Application.use BetterErrors::Middleware
  BetterErrors.application_root = PADRINO_ROOT
  BetterErrors.logger = Padrino.logger
end
=end

Padrino.load!
