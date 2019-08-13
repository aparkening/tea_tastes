# Control user pages
class UsersController < ApplicationController

  #### Edit
  # Show edit form if user has permission
  get '/users/:slug/edit' do 
    # Ensure user can take this action
    authorize

   # Find user
    @user = User.find_by_slug(params[:slug]) 

   # Ensure only owner can edit
    authorize_user(@user)

    erb :'users/edit'  
  end

  # Update in database
  patch '/users/:slug' do  
    # Ensure user can take this action
    authorize

    # Give error message if username is empty
    if params[:user]["username"].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect "/users/#{params[:slug]}/edit"
    else 
      user = User.find_by_slug(params[:slug]) 

      # Ensure only owner can edit
      authorize_user(user)

      # Sanitize input
      params[:user].map { |input| Sanitize.fragment(input) }

      # Update user
      user.update(params[:user])

      # Set message and redirect      
      flash[:message] = ["Success! Profile updated."]
      flash[:type] = "success"
      redirect "/users/#{user.slug}"
    end
  end

  #### Display
  # Display user show page
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
