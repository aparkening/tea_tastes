require './config/environment'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  use Rack::Flash

  
  #### Configuration
  configure do 
    set :views, 'app/views'
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    set :show_exceptions, false
  end


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

    # Return current user or error
    def authorize
      current_user
    end

    # Return user if username and password are authenticated; set session
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
      if post.class == User
        raise AuthorizationError.new if post != current_user
      else 
        raise AuthorizationError.new if post.user != current_user
      end
    end

    # Show login error messages
    def form_error_messages(errors)
      if errors
        erb :'_errors', locals: {errors: errors}
      end
    end

    # Return true if current user owns post
    def own_post?(post)
      logged_in? && current_user == post.user
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

    # Lightly sanitize input
    def clean(input)
      input.downcase.gsub(' ', '-').gsub(/[^-0-9A-Za-z]/, '')
    end

    # Lightly open up input
    def add_space(input)
      input.downcase.gsub('-', ' ')
    end

    # Reclean input, then find objects in database by input type
    def url_find(find)
      # First, clean again
      type = clean(params[:"#{find}"])
    
      # Second, add spaces
      type = add_space(type) 
    
      # Find in database
      @teas = Tea.where("lower(#{find}) = ?", type).order(name: :asc)
    end

  end


  #### Error Helpers
  not_found do
    raise NoResourceError.new
  end

  error 500 do
    erb :error, locals: {
      msg: "Internal Server Error", 
      links: {'/' => 'Go to the home page'}
    }
  end  

  error AuthenticationError do
    status AuthenticationError.status
    erb :error, locals: {msg: AuthenticationError.msg, links: AuthenticationError.links }
  end

  error AuthorizationError do 
    status AuthorizationError.status
    erb :error, locals: {msg: AuthorizationError.msg, links: AuthorizationError.links }
  end

  error NoResourceError do
    status NoResourceError.status
    erb :error, locals: {msg: NoResourceError.msg , links: NoResourceError.links }
  end

  error PostSiteError do
      status PostSiteError.status
      erb :error, locals: {msg: PostSiteError.msg , links: PostSiteError.links }
  end

end