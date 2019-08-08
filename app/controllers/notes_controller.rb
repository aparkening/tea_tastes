# Control notes pages
class NotesController < ApplicationController

  #### Create
  # Display form
  get '/notes/new' do
    redir_login # redirect to login if not authorized to take this action 
    @shops = Shop.all  
    erb :'notes/new'
  end

  # Create and save in database
  post '/notes' do
    redir_login # redirect to login if not authorized to take this action  

    if params[:title].empty? || params[:content].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect '/notes/new'
    else 
      # Create Shop if parameters exist
      if params[:shop][:ids].first.empty? && !params[:shop][:name].empty?
        shop = Shop.new(name: params[:shop][:name])
        shop.url = params[:shop][:url] if params[:shop][:url]
        
        shop_desc = RedCloth.new(params[:shop][:description]).to_html if params[:shop][:description]  # HTMLize description
        shop.description = shop_desc if shop_desc
        shop.save
      else 
        shop = Shop.find_by_id(params[:shop][:ids].first)
      end
      
      # HTMLize textarea content and build new note
      note_content = RedCloth.new(params[:content]).to_html   # HTMLize content
      note = current_user.notes.build(title: params[:title], content: note_content)

      # If note can save, add note to shop and recirect to note.slug
      if note.save
        shop.notes << note if shop # Associate note with shop
        
        flash[:message] = ["Success! Note created."]
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
    redir_login # redirect to login if not authorized to take this action  
    @note = Note.find_by_slug(params[:slug])     
    # Ensure only owner can delete
    if @note.user == current_user
      @note.destroy
      redir_user_home # Redirect to user home
    else
      redirect '/login'
    end    
  end


  #### Edit
  # Show edit form if user has permission
  get '/notes/:slug/edit' do 
    redir_login # redirect to login if not authorized to take this action  
    @note = Note.find_by_slug(params[:slug]) 
    @shops = Shop.all

    # Ensure only owner can edit
    if @note.user == current_user
      erb :'/notes/edit'
    else 
      redirect '/login'
    end      
  end

  # Update in database
  patch '/notes/:slug' do  
    redir_login # redirect to login if not authorized to take this action  

    if params[:note]["title"].empty? || params[:note]["content"].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect "/notes/#{params[:slug]}/edit"
    else 
      note = Note.find_by_slug(params[:slug])  

      # Ensure only owner can edit
      if note.user == current_user

        # Notes can have multiple shops. 
        # If Refactor to check for shop ids and replace the whole section, rather than <<<

        # Set empty shops array if no checkboxes submitted
        if params[:note]["shop_ids"].empty?
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
      else 
        redirect '/login'
      end   
    end
  end


  #### Display
  # Index
  get '/notes' do   
    @notes = Note.all
    erb :'notes/index'
  end

  # Lazy Index, just in case
  get '/notes/' do   
    redirect '/notes'
  end

  # Specific Note
  get '/notes/:slug' do
    @note = Note.find_by_slug(params[:slug])
    erb :'notes/show'
  end


end
