require './config/environment'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  #### Configuration
  configure do 
    set :views, 'app/views'
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, SESSION_SECRET
  end
  # !! BEFORE PRODUCTION: set environment variable secret


  #### Routes
  # Base page
  get '/' do
    erb :index
  end


  #### Helper methods
  helpers do

    # Return true if user session
    def logged_in?
      !!session[:user_id]
    end

    # Return current user based on session
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    # Return true if logged in and current user
    def authorized?
      logged_in? && !current_user.nil?
    end

    # Redirect to login if not authorized
    def redir_login
      if !logged_in? || current_user.nil?
          redirect '/login'
      end
    end

    # Redirect to user home
    def redir_user_home
      redirect "/users/#{current_user.slug}"
    end

  end

end