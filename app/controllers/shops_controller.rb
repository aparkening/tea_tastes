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
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect "/shops/#{params[:slug]}/edit"
    else 
      shop = Shop.find_by_slug(params[:slug]) 
      
      # Sanitize text inputs  
      params[:shop].map { |input| Sanitize.fragment(input) }

      # HTMLize description
      if description = params[:shop]["description"]
        params[:shop]["description"] = RedCloth.new(description).to_html
      end     

      # Update shop
      shop.update(params[:shop])

      # Set message and redirect
      if shop.errors.any?
        flash[:message] = shop.errors.full_messages
        flash[:type] = "error"  
        redirect "/shops/#{params[:slug]}/edit"
      else
        flash[:message] = ["Success! Shop updated."]
        flash[:type] = "success"
        redirect "/shops/#{shop.slug}"
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
    flash[:message] = ["Shop deleted"]
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
    raise NoResourceError.new if !@shop
    erb :'shops/show'
  end

end