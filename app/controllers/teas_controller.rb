# Control teas pages
class TeasController < ApplicationController

  #### Create
  # Display form
  get '/teas/new' do
    # Ensure user can take this action
    authorize

    @shops = Shop.all  
    # @teas = Tea.all
    @categories = Tea.select(:category).distinct
    
    erb :'teas/new'
  end

  # Create and save in database
  post '/teas' do

    # Ensure user can take this action
    authorize

    if params[:tea]["name"].empty? || params[:tea]["category"].empty? || params[:tea]["description"].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect '/teas/new'
    else 
      # Create Shop if parameters exist
      if !params[:shop_name].empty?
        shop = Shop.new(name: params[:shop_name])
        shop.url = params[:shop_url] if params[:shop_url]
        
        shop_desc = RedCloth.new(params[:shop_description]).to_html if params[:shop_description]  # HTMLize description
        shop.description = shop_desc if shop_desc
        shop.save
      end

      # Set current_user
      user = current_user

      # HTMLize content  
      params[:tea]["description"] = RedCloth.new(params[:tea]["description"]).to_html 
      # Build tea
      tea = Tea.new(params[:tea])

      # If tea can save, add tea to shop and redirect
      if tea.save
        # Add tea to shop if exists
        shop.teas << tea if shop

        flash[:message] = ["Nice work! Note created."]
        flash[:type] = "success"
        redirect to "/teas/#{tea.slug}"
      else
        if tea.errors.any?
          flash[:message] = note.errors.full_messages
          flash[:type] = "error"
        end
        redirect to "/teas/new"
      end      
    end
  end


  #### Delete Note
  delete '/teas/:slug' do
    # Ensure user can take this action
    authorize

    tea = Tea.find_by_slug(params[:slug])     
    tea.destroy
    # redir_user_home # Redirect to user home
    redirect '/teas'
  end

  # If manual delete, redirect to /
  get '/teas/:slug/delete' do
    redirect '/'
  end


  #### Edit
  # Show edit form if user has permission
  get '/teas/:slug/edit' do 
    # Ensure user can take this action
    authorize

    # redir_login # redirect to login if not authorized to take this action  
    @tea = Tea.find_by_slug(params[:slug]) 
    @shops = Shop.all
    @categories = Tea.select(:category).distinct

    erb :'teas/edit'
  end

  # Update in database
  patch '/teas/:slug' do  
    # Ensure user can take this action
    authorize

    if params[:tea]["name"].empty? || params[:tea]["category"].empty? || params[:tea]["description"].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect "/teas/#{params[:slug]}/edit"
    else 
      tea = Tea.find_by_slug(params[:slug])  

      # Reset shops array if no checkboxes submitted
      # if params[:tea]["shop_ids"].nil?
      #   params[:tea]["shop_ids"] = []
      # end

      # Create Shop if parameters exist
      if !params[:shop_name].empty?
        shop = Shop.new(name: params[:shop_name])
        shop.url = params[:shop_url] if params[:shop_url]
        
        shop_desc = RedCloth.new(params[:shop_description]).to_html if params[:shop_description]  # HTMLize description
        shop.description = shop_desc if shop_desc
        shop.save
      end

      # HTMLize content  
      params[:tea]["description"] = RedCloth.new(params[:tea]["description"]).to_html 
      # Update note
      tea.update(params[:tea])

      # Add tea to shop if exists
      shop.teas << tea if shop
      
      flash[:message] = ["Success! Note updated."]
      flash[:type] = "success"
      
      redirect "/teas/#{params[:slug]}"
    end
  end


  #### Display
  # Index
  get '/teas/?' do 
    # teas by newest first
    @teas = Tea.all.order(created_at: :desc)
    erb :'teas/index'
  end

  # Category Index
  get '/teas/category/:category' do
    url_find("category")
    erb :'teas/index'
  end

  # Region Index
  get '/teas/region/:region' do
    url_find("region")
    erb :'teas/index'
  end

  # Country Index
  get '/teas/country/:country' do
    url_find("country")
    erb :'teas/index'
  end 

  # Specific Note
  get '/teas/:slug' do
    @tea = Tea.find_by_slug(params[:slug])
    erb :'teas/show'
  end

end
