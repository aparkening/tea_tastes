# Control notes pages
class NotesController < ApplicationController

  #### Create
  # Display form
  get '/notes/new' do
    # Ensure user can take this action
    authorize

    # redir_login # redirect to login if not authorized to take this action 
    @shops = Shop.all  
    erb :'notes/new'
  end

  # Create and save in database
  post '/notes' do
    # Ensure user can take this action
    authorize

    # redir_login # redirect to login if not authorized to take this action  

    if params[:note]["title"].empty? || params[:note]["content"].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect '/notes/new'
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
      params[:note]["content"] = RedCloth.new(params[:note]["content"]).to_html 
      # Build note
      note = user.notes.build(params[:note])

      # raise PostSiteError.new if !user.save 
      # Add shop to note
      # note.shops << shop if shop
      # redirect "/notes/#{note.slug}"

      # If note can save, add note to shop and redirect to note.slug
      if note.save
        note.shops << shop if shop
        flash[:message] = ["Nice work! Note created."]
        flash[:type] = "success"
        redirect to "/notes/#{note.slug}"
      else
        if note.errors.any?
          flash[:message] = note.errors.full_messages
          flash[:type] = "error"
        end
        redirect to "/notes/new"
      end      
    end
  end


  #### Delete Note
  delete '/notes/:slug/delete' do
    # Ensure user can take this action
    authorize

    note = Note.find_by_slug(params[:slug])     

    # Ensure only owner can edit
    authorize_user(note)

    note.destroy
    redir_user_home # Redirect to user home

    # redir_login # redirect to login if not authorized to take this action  

    # # Ensure only owner can delete
    # if @note.user == current_user
      # @note.destroy
      # redir_user_home # Redirect to user home
    # else
    #   redirect '/login'
    # end    
  end


  #### Edit
  # Show edit form if user has permission
  get '/notes/:slug/edit' do 
    # Ensure user can take this action
    authorize

    # redir_login # redirect to login if not authorized to take this action  
    @note = Note.find_by_slug(params[:slug]) 
    @shops = Shop.all

   # Ensure only owner can edit
    authorize_user(@note)
    erb :'/notes/edit'

    # # Ensure only owner can edit
    # if @note.user == current_user
    #   erb :'/notes/edit'
    # else 
    #   redirect '/login'
    # end      
  end

  # Update in database
  patch '/notes/:slug' do  
    # Ensure user can take this action
    authorize

    # redir_login # redirect to login if not authorized to take this action  

    if params[:note]["title"].empty? || params[:note]["content"].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect "/notes/#{params[:slug]}/edit"
    else 
      note = Note.find_by_slug(params[:slug])  

      # Ensure only owner can edit
      authorize_user(note)

      # Ensure only owner can edit
      # if note.user == current_user

        # Reset shops array if no checkboxes submitted
        if params[:note]["shop_ids"].nil?
          params[:note]["shop_ids"] = []
        end

        # Create Shop if parameters exist
        if !params[:shop_name].empty?
          shop = Shop.new(name: params[:shop_name])
          shop.url = params[:shop_url] if params[:shop_url]
          
          shop_desc = RedCloth.new(params[:shop_description]).to_html if params[:shop_description]  # HTMLize description
          shop.description = shop_desc if shop_desc
          shop.save
        end

        # HTMLize content  
        params[:note]["content"] = RedCloth.new(params[:note]["content"]).to_html 
        # Update note
        note.update(params[:note])
        # Add new shop if exists
        note.shops << shop if shop

        flash[:message] = ["Success! Note updated."]
        flash[:type] = "success"
        
        redirect "/notes/#{params[:slug]}"
      # else 
      #   redirect '/login'
      # end   
    end
  end


  #### Display
  # Index
  get '/notes' do   
    # Notes by newest first
    @notes = Note.all.order(created_at: :desc)
    erb :'notes/index'
  end

  # # Lazy Index, just in case
  # get '/notes/' do   
  #   redirect '/notes'
  # end

  # Specific Note
  get '/notes/:slug' do
    @note = Note.find_by_slug(params[:slug])
    erb :'notes/show'
  end


end
