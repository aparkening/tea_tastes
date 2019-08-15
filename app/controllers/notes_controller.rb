# Control notes pages
class NotesController < ApplicationController

  #### Create
  # Display form
  get '/notes/new' do
    # Ensure user can take this action
    authorize
    @teas = Tea.all.order(name: :asc)
    erb :'notes/new'
  end

  # Create and save in database
  post '/notes' do
    # Ensure user can take this action
    authorize

    # Give error message if title or content are empty
    if params[:note]["title"].empty? || params[:note]["content"].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect '/notes/new'
    else 
      # Set current_user
      user = current_user

      # Sanitize text inputs
      params[:note]["title"] = Sanitize.fragment(params[:note]["title"])
      params[:note]["content"] = Sanitize.fragment(params[:note]["content"])

      # HTMLize content  
      params[:note]["content"] = RedCloth.new(params[:note]["content"]).to_html 

      # Turn rating into integer
      if rating = params[:note]["rating"]
        params[:note]["rating"] = rating.to_i
      end

      # Build note
      note = user.notes.build(params[:note])

      # If note can save, add note to shop and redirect.
      if note.save
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
  delete '/notes/:slug' do
    # Ensure user can take this action
    authorize

    note = Note.find_by_slug(params[:slug])     
    # Ensure only owner can edit
    authorize_user(note)

    # Delete object and redirect
    note.destroy

    # Set message and redirect
    flash[:message] = ["Note deleted"]
    flash[:type] = "success"
    redir_user_home
  end

  # If manual delete, redirect to /
  get '/notes/:slug/delete' do
    redirect '/'
  end


  #### Edit
  # Show edit form if user has permission
  get '/notes/:slug/edit' do 
    # Ensure user can take this action
    authorize

    # Find note
    @note = Note.find_by_slug(params[:slug])
    @teas = Tea.all.order(name: :asc)
   
    # Ensure only owner can edit
    authorize_user(@note)

    erb :'notes/edit'    
  end

  # Update in database
  patch '/notes/:slug' do  
    # Ensure user can take this action
    authorize

    # Give error message if title or content are empty
    if params[:note]["title"].empty? || params[:note]["content"].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect "/notes/#{params[:slug]}/edit"
    else 
      note = Note.find_by_slug(params[:slug])

      # Ensure only owner can edit
      authorize_user(note)

      # Turn rating into integer
      if rating = params[:note]["rating"]
        params[:note]["rating"] = rating.to_i
      end

      # Sanitize text inputs
      params[:note]["title"] = Sanitize.fragment(params[:note]["title"])
      params[:note]["content"] = Sanitize.fragment(params[:note]["content"])

      # HTMLize content  
      params[:note]["content"] = RedCloth.new(params[:note]["content"]).to_html 

      # Update note
      note.update(params[:note])

      # Set message and redirect
      if note.errors.any?
        flash[:message] = note.errors.full_messages
        flash[:type] = "error"  
        redirect "/notes/#{params[:slug]}/edit"
      else
        flash[:message] = ["Success! Note updated."]
        flash[:type] = "success"
        redirect "/notes/#{note.slug}"
      end
    end
  end


  #### Display
  # Index
  get '/notes/?' do   
    # Notes by newest first
    @notes = Note.all.order(created_at: :desc)
    erb :'notes/index'
  end

  # Specific Note
  get '/notes/:slug' do
    @note = Note.find_by_slug(params[:slug])
    raise NoResourceError.new if !@note
    erb :'notes/show'
  end

end
