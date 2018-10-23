require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

# namespace :db do
  # task :seed do
  #   exec("ruby db/seeds.rb")
  # end
# end
