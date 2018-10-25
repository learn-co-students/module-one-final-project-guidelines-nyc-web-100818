require 'bundler'
Bundler.require
ActiveRecord::Base.logger = nil

require 'rest-client'
require 'json'
require 'pry'
require 'require_all'
require 'colorize'


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
