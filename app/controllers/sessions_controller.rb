# Control signup, login, and logout
class SessionsController < ApplicationController

  #### Signup
  # Display signup page
  get '/signup' do
    if logged_in?
      redir_user_home
    else 
      erb :'users/new'
    end
  end

  # Create user
  post '/signup' do

    # Give error message if username or password are empty or if password doesn't match confirmation
    if params[:user]["username"].empty? || params[:user]["password"].empty? || (params[:user]["password"] != params[:user]["password_confirmation"])
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect "/signup"
    else 
      # Sanitize input
      params[:user].map { |input| Sanitize.fragment(input) }

      # Create user
      user = User.new(params[:user])
    end

    # If no errors on save, set session id and go to user home
    if user.save
      session[:user_id] = user.id
      redir_user_home
    else
      if user.errors.any?
        flash[:message] = user.errors.full_messages
        flash[:type] = "error"
      end
      redirect '/signup'
    end
  end


  #### Login
  # Display login page
  get '/login' do
    if logged_in?
      redir_user_home
    else 
      erb :'users/login'
    end
  end

  # Get user from database
  post '/login' do
    begin 
      authenticate(params[:user]["username"], params[:user]["password"])
      redir_user_home
    rescue AuthenticationError => e 
      @errors = ["Improper information entered"]
      erb :'users/login'
    end

    # user = User.find_by(username: params[:username])
    # # If user exists, set session and redirect to user home
    # if user && user.authenticate(params[:password])
    #   session[:user_id] = user.id
    #   redir_user_home
    # else
    #   redirect '/login'
    # end
  end


  #### Logout
  # get '/logout' do
  #   session.clear if logged_in?
  #   redirect '/'
  # end
  delete '/logout' do
    session.clear if logged_in?
    flash[:message] = ["Successfully logged out."]
    flash[:type] = "success"
    redirect '/login'
  end

end