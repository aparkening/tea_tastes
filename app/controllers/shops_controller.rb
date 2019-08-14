# Control shop pages
class ShopsController < ApplicationController

  #### Edit
  # Show edit form if user has permission
  get '/shops/:slug/edit' do 
    # Ensure user can take this action
    authorize
    @shop = Shop.find_by_slug(params[:slug]) 
    erb :'shops/edit'
  end

  # Update in database
  patch '/shops/:slug' do  
    # Ensure user can take this action
    authorize

    # Give error message if name is empty
    if params[:shop]["name"].empty?
      flash[:message] = ["Name is missing. Please fill in Name and re-submit."]
      flash[:type] = "error"
      redirect "/shops/#{params[:slug]}/edit"
    else 
      shop = Shop.find_by_slug(params[:slug]) 
      
      # Sanitize text inputs
      params[:shop]["name"] = Sanitize.fragment(params[:shop]["name"])
      if url = params[:shop]["url"]
        params[:shop]["url"] = Sanitize.fragment(url)
      end
      if description = params[:shop]["description"]
        params[:shop]["description"] = Sanitize.fragment(description)
      end      
      
      # HTMLize description
      if description = params[:shop]["description"]
        params[:shop]["description"] = RedCloth.new(description).to_html
      end     
      
      # Update shop
      shop.update(params[:shop])

      # Set message and redirect
      if shop.errors.any?
        flash[:message] = note.errors.full_messages
        flash[:type] = "error"  
        redirect "/shops/#{params[:slug]}/edit"
      else
        flash[:message] = ["Success! Shop updated."]
        flash[:type] = "success"
        redirect "/shops/#{note.slug}"
      end
    end
  end


  #### Delete Shop
  delete '/shops/:slug/delete' do
    # Ensure user can take this action
    authorize    

    @shop = Shop.find_by_slug(params[:slug])    
    @shop.destroy

    # Set message and redirect
    flash[:message] = ["'#{shop.name}' shop deleted"]
    flash[:type] = "success"
    redirect '/shops'    
  end

  # If manual delete, redirect to /
  get '/shops/:slug/delete' do
    redirect '/'
  end


  #### Display
  # Index
  get '/shops/?' do   
    @shops = Shop.all
    erb :'shops/index'
  end

  # Specific Shop
  get '/shops/:slug' do
    @shop = Shop.find_by_slug(params[:slug])
    erb :'shops/show'
  end

end