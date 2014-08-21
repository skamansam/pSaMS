##
# You can use other adapters like:
#
#   ActiveRecord::Base.configurations[:development] = {
#     :adapter   => 'mysql2',
#     :encoding  => 'utf8',
#     :reconnect => true,
#     :database  => 'your_database',
#     :pool      => 5,
#     :username  => 'root',
#     :password  => '',
#     :host      => 'localhost',
#     :socket    => '/tmp/mysql.sock'
#   }
#
# SQLite Configurtion
ActiveRecord::Base.configurations[:development] = {
  :adapter => 'sqlite3',
  :database => Padrino.root('db', 'pSaMS_development.db')

}

=begin # MongoDB configuration

ActiveRecord::Base.configurations[:development] = {
  :adapter => 'mongodb',
  :database => 'pSaMS_development'

}

=end

if ENV['PG_DB'] && ENV['PG_USER'] && ENV['PG_PASS']  # we are using Heroku
   ActiveRecord::Base.configurations[:production] = ENV['HEROKU_POSTGRESQL_CRIMSON_URL']
#   {
#     :adapter   => 'pg',
#     :ssl       => true,
#     :encoding  => 'utf8',
#     :reconnect => true,
#     :database  => ENV['PG_DB'],
#     :username  => ENV['PG_USER'],
#     :password  => ENV['PG_PASS'],
#     :host      => ENV['PG_HOST']
#   }
else

  # MySQL or MariaDB Configuration
  ActiveRecord::Base.configurations[:production] = {
    :adapter => 'mysql2',
    :database => 'pSaMS',
      :host=>ENV['OPENSHIFT_MYSQL_DB_HOST'],
      :port => ENV['OPENSHIFT_MYSQL_DB_PORT'].to_i,
      :username => ENV['OPENSHIFT_MYSQL_DB_USERNAME'],
      :password => ENV['OPENSHIFT_MYSQL_DB_PASSWORD']
  }

end
ActiveRecord::Base.configurations[:test] = {
  :adapter => 'sqlite3',
  :database => Padrino.root('db', 'pSaMS_test.db')

}

# Setup our logger
ActiveRecord::Base.logger = logger

if ActiveRecord::VERSION::MAJOR.to_i < 4
  # Raise exception on mass assignment protection for Active Record models.
  ActiveRecord::Base.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL).
  ActiveRecord::Base.auto_explain_threshold_in_seconds = 0.5
end

# Doesn't include Active Record class name as root for JSON serialized output.
ActiveRecord::Base.include_root_in_json = false

# Store the full class name (including module namespace) in STI type column.
ActiveRecord::Base.store_full_sti_class = true

# Use ISO 8601 format for JSON serialized times and dates.
ActiveSupport.use_standard_json_time_format = true

# Don't escape HTML entities in JSON, leave that for the #json_escape helper
# if you're including raw JSON in an HTML page.
ActiveSupport.escape_html_entities_in_json = false

# Now we can establish connection with our db.
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Padrino.env])
