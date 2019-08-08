require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  use Rack::Flash

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
    @notes = Note.all
    erb :index
  end


  #### Helper methods
  helpers do

    # Return true if user has session and is in database
    def logged_in?
      !!User.find_by(id: session[:user_id])
    end

    # Return current user or raise error
    def current_user
      user = User.find_by(id: session[:user_id])
      raise AuthenticationError.new if user.nil?
      user
    end

    # Return user if username and password are authenticated
    def authenticate(username, password)
      user = User.find_by(username: username)
      raise AuthenticationError.new unless !!user
      raise AuthenticationError.new if !user.authenticate(password)
      session[:user_id] = user.id
      user
    end

    # Raise errors if user doesn't have permissions to access post
    def authorize_user(post)
      raise NoResourceError.new if !post
      raise AuthorizationError.new if post.user != current_user
    end

    # Show login error messages
    def login_error_messages(errors)
      if errors
          erb :'sessions/_errors', locals: {errors: errors}
      end
    end

    # Return true if current user owns post
    def own_post?(post)
        current_user == post.user
    end

    # Return current user
    # def authorize
    #   current_user
    # end

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


  #### Error classes
  error AuthenticationError do
    status AuthenticationError.status
    erb :error, locals: {msg: AuthenticationError.msg, links: AuthenticationError.links }, layout: false
  end

  error AuthorizationError do 
      status AuthorizationError.status
      erb :error, locals: {msg: AuthorizationError.msg, links: AuthorizationError.links }, layout: false
  end

  error NoResourceError do
      status NoResourceError.status
      erb :error, locals: {msg: NoResourceError.msg , links: NoResourceError.links }, layout: false
  end

  error PostSiteError do
      status PostSiteError.status
      erb :error, locals: {msg: PostSiteError.msg , links: PostSiteError.links }, layout: false
  end


end