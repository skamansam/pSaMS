#require 'rake/hooks'
ENV['MIGRATIONS']='1'
namespace :db do
  desc "Annotate models, specs, tests, routes, etc."
  task annotate: ['migrate'] do
    exec 'annotate -i --model-dir models '
  end
end
