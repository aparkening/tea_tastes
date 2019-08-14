# Control teas pages
class TeasController < ApplicationController

  #### Create
  # Display form
  get '/teas/new' do
    # Ensure user can take this action
    authorize
    @shops = Shop.all  
    @categories = Tea.select(:category).distinct
    erb :'teas/new'
  end

  # Create and save in database
  post '/teas' do
    # Ensure user can take this action
    authorize

    # Give error message if name, category, or description are empty
    if params[:tea]["name"].empty? || params[:tea]["category"].empty? || params[:tea]["description"].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect '/teas/new'
    else 
      # Create Shop if parameters exist
      if !params[:shop]["name"].empty?
        
        # Sanitize input
        params[:shop].map { |input| Sanitize.fragment(input) }

        # HTMLize description
        if description = params[:shop]["description"]
          params[:shop]["description"] = RedCloth.new(description).to_html
        end   

        # Create shop
        shop = Shop.new(params[:shop])
        shop.save

        # If errors, set message and redirect
        if shop.errors.any?
          flash[:message] = shop.errors.full_messages
          flash[:type] = "error"  
          redirect to "/teas/new"
        end
      end

      # Set current_user
      user = current_user

      # Sanitize input
      params[:tea].map { |input| Sanitize.fragment(input) }

      # HTMLize content  
      params[:tea]["description"] = RedCloth.new(params[:tea]["description"]).to_html 
      
      # Build tea
      tea = Tea.new(params[:tea])

      # If tea can save, add tea to shop and redirect.
      if tea.save
        # Add tea to shop if exists
        shop.teas << tea if shop

        flash[:message] = ["Nice work! Note created."]
        flash[:type] = "success"
        redirect to "/teas/#{tea.slug}"
      else
        if tea.errors.any?
          flash[:message] = tea.errors.full_messages
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

    # Delete object and redirect
    tea.destroy

    # Set message and redirect
    flash[:message] = ["'#{tea.name}' tea deleted"]
    flash[:type] = "success"
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

    # Find tea, shops, and tea categories
    @tea = Tea.find_by_slug(params[:slug]) 
    @shops = Shop.all
    @categories = Tea.select(:category).distinct

    erb :'teas/edit'
  end

  # Update in database
  patch '/teas/:slug' do  
    # Ensure user can take this action
    authorize

    # Give error message if name, category, or description are empty
    if params[:tea]["name"].empty? || params[:tea]["category"].empty? || params[:tea]["description"].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect "/teas/#{params[:slug]}/edit"
    else 
      tea = Tea.find_by_slug(params[:slug])  

      # Create Shop if parameters exist
      if !params[:shop]["name"].empty?
              
        # Sanitize input
        params[:shop].map { |input| Sanitize.fragment(input) }

        # HTMLize description
        if description = params[:shop]["description"]
          params[:shop]["description"] = RedCloth.new(description).to_html
        end   

        # Create shop
        shop = Shop.new(params[:shop])
        shop.save

        # If errors, set message and redirect
        if shop.errors.any?
          flash[:message] = shop.errors.full_messages
          flash[:type] = "error"  
          redirect to "/teas/new"
        end
      end

      # Sanitize input
      params[:tea].map { |input| Sanitize.fragment(input) }

      # HTMLize content  
      params[:tea]["description"] = RedCloth.new(params[:tea]["description"]).to_html 
      
      # Update note
      tea.update(params[:tea])

      # Add tea to shop if exists
      shop.teas << tea if shop
      
      # Set message and redirect
      flash[:message] = ["Success! Note updated."]
      flash[:type] = "success"
      redirect "/teas/#{tea.slug}"
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