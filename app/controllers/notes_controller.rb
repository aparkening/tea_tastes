# Control notes pages
class NotesController < ApplicationController




  #### Create
  # Display form
  get '/notes/new' do
    redir_login # redirect if not authorized to take this action      
    erb :'notes/new'
  end

  # Create and save in database
  post '/notes' do
    if params[:title].empty? || params[:content].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect '/notes/new'
    else 
      note = current_user.notes.build(title: params[:title], content: params[:content])
      if note.save
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
    redir_login # redirect if not authorized to take this action  
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
    redir_login # redirect if not authorized to take this action  
    @note = Note.find_by_slug(params[:slug])  
    
    # Ensure only owner can edit
    if @note.user == current_user
      erb :'/notes/edit'
    else 
      redirect '/login'
    end      
  end

  # Update in database
  patch '/notes/:slug' do  
    redir_login # redirect if not authorized to take this action  

    if params[:title].empty? || params[:content].empty?
      flash[:message] = ["Fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect "/notes/#{params[:slug]}/edit"
    else 
      @note = Note.find_by_slug(params[:slug])  

      # Ensure only owner can edit
      if @note.user == current_user
        @note.update(title: params[:title], content: params[:content])
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

  # Specific Note
  get '/notes/:slug' do
    @note = Note.find_by_slug(params[:slug])
    erb :'notes/show'
  end

end
