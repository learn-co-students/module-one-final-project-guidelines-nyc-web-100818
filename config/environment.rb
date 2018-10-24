require 'bundler'
Bundler.require

require 'rest-client'
require 'json'
require 'pry'
require 'require_all'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
