require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ("db/#{ENV['RACK_ENV']}.sqlite3"))