source 'https://rubygems.org'

# Distribute your app as a gem
# gemspec

# Server requirements
gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

gem 'i18n'

# Project requirements
gem 'rake'

# Component requirements
gem 'bcrypt'
gem 'will_paginate', '~>3.0'
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'sass'
gem 'haml'
gem 'coffee-script'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'sqlite3', :group=>['development','test']
#gem 'mongodb', :group=>['development','test']
gem 'pg', :group=>'production'
gem 'mysql2', :group=>'production'

# Test requirements
group :test do 
  #gem 'shoulda'
  gem 'rspec'
  gem 'forgery'
  gem 'factory_girl'
  gem 'capybara'
  gem 'cucumber'
  gem 'rack-test', :require => 'rack/test'
  gem 'database_cleaner'
end

group :development do
  gem 'pry'
  gem 'pry-rescue'
end

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.11.4'
# end

gem 'padrino-sprockets', :require => "padrino/sprockets" #, :path=>"/home/sam/workspace/padrino-sprockets" #:git=>https://github.com/skamansam/padrino-sprockets.git

gem 'therubyracer'

# enable js minification
gem 'uglifier'
gem 'closure-compiler', :group => 'production'

# enable css compression
gem 'yui-compressor'
gem 'less'

#gems for extensibility
#gem 'actionview'
#gem 'acts-as-taggable-on', '2.4.1'
gem 'rdiscount'  #for markdown processing

# for caching. 
#gem 'memcached' #disabled for Openshift
#gem 'redis'

# Padrino Stable Gem
gem 'padrino'

# Or Padrino Edge
#gem 'padrino', :github => 'padrino/padrino-framework'


