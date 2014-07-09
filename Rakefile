require 'bundler/setup'
require 'padrino-core/cli/rake'
require 'i18n'

#spec = Gem::Specification.find_by_name 'acts-as-taggable-on'
#load "#{spec.gem_dir}/tasks/deploy.rake"

#Padrino::Tasks.files.concat(Dir["#{spec.gem_dir}//*"])
#puts spec.inspect
#puts Dir["#{spec.gem_dir}/db/migrate*"]

PadrinoTasks.use(:database)
PadrinoTasks.use(:activerecord)
PadrinoTasks.init
