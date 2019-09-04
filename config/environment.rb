ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

# If development environment, grab local secret key
if ENV['SINATRA_ENV'] == 'development' 
  require './secrets.rb'
end 

require 'rack-flash'
require 'sanitize'
require './constants.rb'
require './errors/post_site_error'
require_all 'errors'
require_all 'app'
