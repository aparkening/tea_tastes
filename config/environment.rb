ENV['SINATRA_ENV'] ||= "development"
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

# If development environment, grab secret key
if ENV['SINATRA_ENV'] == 'development' 
  require './secrets.rb'
end 
require './constants.rb'

require_all 'app'