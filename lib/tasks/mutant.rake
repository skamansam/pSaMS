
namespace :metrics do
  require 'mutant'

  desc 'Run mutant'
  task :mutant do #:coverage do
    # Eager load application and dependencies
    require File.expand_path('../../../config/boot', __FILE__)

    # put model dirs here. NOTE: controllers don't work here.
    # See the `Application Design` section of the README for more information.
    dirs = ['models', 'app/interactors', 'app/presenters', 'admin/interactors']
    out = ""
    dirs.each do |dir|
      Dir["#{dir}/**/*.rb"].each do |file|
        class_name = file.sub(dir+'/','').sub('.rb','').classify
        puts out += "\nMutating #{class_name}\n#{file}============================"
        args = ['--use', 'rspec', '--zombie', class_name.to_s, '*']
        mutant = Mutant::Runner.call(Mutant::Env::Bootstrap.call(Mutant::CLI.call(args)))
        puts out += "*** FAILED: ***" unless mutant.success?
        out += "Coverage: #{mutant.coverage}\n"
        out += "Overhead: #{mutant.overhead}\n"
        mutant.failed_subject_results .each do |failed_result|
          failed_result.send(:alive_mutation_results).each do |results|
            # binding.pry
            out += "FAILED TEST: \n\t#{results}\n"
          end
        end
      end
    end
    puts out
    File.open("log/mutant.txt", 'w') {|f| f.write(out) }
  end
end
