# Control shop pages
class ShopsController < ApplicationController

  #### Edit
  # Show edit form if user has permission
  get '/shops/:slug/edit' do 
    # Ensure user can take this action
    authorize
    
    #redir_login # redirect to login if not authorized to take this action  
    
    @shop = Shop.find_by_slug(params[:slug]) 
    erb :'/shops/edit'
  end

  # Update in database
  patch '/shops/:slug' do  
    # Ensure user can take this action
    authorize

    # redir_login # redirect to login if not authorized to take this action  

    if params[:shop]["name"].empty?
      flash[:message] = ["Name is missing. Please fill in Name and re-submit."]
      flash[:type] = "error"
      redirect "/shops/#{params[:slug]}/edit"
    else 
      shop = Shop.find_by_slug(params[:slug]) 
      params[:shop]["description"] = RedCloth.new(params[:shop]["description"]).to_html if params[:shop]["description"]
      shop.update(params[:shop])

      flash[:message] = ["Success! Shop updated."]
      flash[:type] = "success"
        
      redirect "/shops/#{params[:slug]}" 
    end
  end


  #### Delete Shop
  delete '/shops/:slug/delete' do
    # Ensure user can take this action
    authorize    

    # redir_login # redirect to login if not authorized to take this action 

    @shop = Shop.find_by_slug(params[:slug])     
    @shop.destroy
    redirect '/shops'    
  end


  #### Display
  # Index
  get '/shops' do   
    @shops = Shop.all
    erb :'shops/index'
  end

  # Lazy Index, just in case
  get '/shops/' do   
    redirect '/shops'
  end

  # Specific Shop
  get '/shops/:slug' do
    @shop = Shop.find_by_slug(params[:slug])
    erb :'shops/show'
  end

end