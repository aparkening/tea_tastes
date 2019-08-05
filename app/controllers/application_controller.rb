class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do 
    set :views, 'app/views'
    set :public_folder, 'public'

    enable :sessions
    set :session_secret, SESSION_SECRET
  end
  # BEFORE PRODUCTION: set environment variable secret

  get '/' do
    erb :index
  end
end