##
# You can use other adapters like:
#
#   ActiveRecord::Base.configurations[:development] = {
#     adapter:   'mysql2',
#     encoding:  'utf8',
#     reconnect: true,
#     database:  'your_database',
#     pool:      5,
#     username:  'root',
#     password:  '',
#     host:      'localhost',
#     socket:    '/tmp/mysql.sock'
#   }
#

# SQLite Configurtion for local developer testing
ActiveRecord::Base.configurations[:development] = {
  adapter: 'sqlite3',
  database: Padrino.root('db', 'pSaMS_development.db'),
  #wait_timeout: 10,
  #timeout: 250,
  pool: 3
}

=begin # MongoDB configuration

ActiveRecord::Base.configurations[:development] = {
  adapter: 'mongodb',
  database: 'pSaMS_development'
}

=end

# database for testing, the defaults should be enough.
ActiveRecord::Base.configurations[:test] = {
  adapter: 'mysql2',
  database: 'pSaMS_test',
  username: 'root'

  # Use this if you want to use sqlite for testing. I wouldn't recommend this, though,
  # due to the nature of sqlite being single-threaded. This means in order to run
  # mutation testing, you have to use the `--jobs 1` option, which makes tings
  # really really slow.
  # adapter: 'sqlite3',
  # database: Padrino.root('db', 'pSaMS_test.db')

}

# detect production environment
db_adapter = ENV['PG_DB'].present? ? 'pg' : 'mysql2'
db_name = ENV['PG_DB'] || 'pSaMS'
db_host = ENV['PG_HOST'] || ENV['OPENSHIFT_MYSQL_DB_HOST']
db_port = (
  ENV['PG_PORT'] || ENV['OPENSHIFT_MYSQL_DB_PORT'] ||
  (5_432 if db_adapter == 'pg') || (5_432 if db_adapter == 'mysql2') ||
  (27_017 if db_adapter == 'mongodb')
).to_i
db_user = ENV['PG_USER'] || ENV['OPENSHIFT_MYSQL_DB_USERNAME'] || 'root'
db_password = ENV['PG_PASS'] || ENV['OPENSHIFT_MYSQL_DB_PASSWORD'] || ''
db_ssl = ENV.key?('HEROKU_POSTGRESQL_CRIMSON_URL')
db_reconnect = ENV.key?('HEROKU_POSTGRESQL_CRIMSON_URL')

ActiveRecord::Base.configurations[:production] = {
  adapter:   db_adapter,
  ssl:       db_ssl,
  encoding:  'utf8',
  reconnect: db_reconnect,
  database:  db_name,
  username:  db_user,
  password:  db_password,
  host:      db_host,
  port:      db_port
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
