# Control notes pages
class NotesController < ApplicationController

  #### Create
  # Display form
  get '/notes/new' do
    # Ensure user can take this action
    authorize
    @teas = Tea.all.order(name: :asc)
    @shops = Shop.all.order(name: :asc)
    erb :'notes/new'
  end

  # Create and save in database
  post '/notes' do
    # Ensure user can take this action
    authorize

    # Give error message if title or content are empty
    if params[:note]["title"].empty? || params[:note]["content"].empty?
      flash[:message] = ["Note fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect '/notes/new'
    else 
      # Set current_user
      user = current_user

      ## Build Note from input
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


      ## Build Shop from input
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
            error_section = "New Shop Error"
            flash[:message].unshift(error_section)
            flash[:type] = "error"  
            redirect to "/notes/new"
          end
        end # end shop fields empty conditional


      ## Build Tea from input
        # Create Tea if parameters exist
        if !params[:tea]["name"].empty?
          # Give error message if category or description are empty
          if params[:tea]["category"].empty? || params[:tea]["description"].empty?
            flash[:message] = ["New Tea fields are missing data. Please submit again."]
            flash[:type] = "error"
            redirect '/notes/new'
          else
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
            else
              if tea.errors.any?
                flash[:message] = tea.errors.full_messages
                error_section = "New Tea Error"
                flash[:message].unshift(error_section)
                flash[:type] = "error"
              end
              redirect to "/notes/new"
            end     
          end
        end # end tea fields empty conditional

      # If note can save, add note to tea and redirect.
      if note.save
        tea.notes << note if tea
        flash[:message] = ["Nice work! Note created."]
        flash[:type] = "success"
        redirect to "/notes/#{note.slug}"
      else
        if note.errors.any?
          flash[:message] = note.errors.full_messages
          error_section = "Note Error"
          flash[:message].unshift(error_section)
          flash[:type] = "error"
        end
        redirect to "/notes/new"
      end # end note save conditional
    end # end notes fields empty conditional
  end # end post /notes


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
    flash[:message] = ["Note deleted."]
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
    @shops = Shop.all.order(name: :asc)
   
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
      flash[:message] = ["Note fields are missing data. Please submit again."]
      flash[:type] = "error"
      redirect "/notes/#{params[:slug]}/edit"
    else 
      note = Note.find_by_slug(params[:slug])

      # Ensure only owner can edit
      authorize_user(note)

      ## Update Note from input
        # Sanitize text inputs
        params[:note]["title"] = Sanitize.fragment(params[:note]["title"])
        params[:note]["content"] = Sanitize.fragment(params[:note]["content"])

        # HTMLize content  
        params[:note]["content"] = RedCloth.new(params[:note]["content"]).to_html 

        # Turn rating into integer
        if rating = params[:note]["rating"]
          params[:note]["rating"] = rating.to_i
        end

        # Update note
        note.update(params[:note])


      ## Build Shop from input
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
            error_section = "New Shop Error"
            flash[:message].unshift(error_section)
            flash[:type] = "error"  
            redirect "/notes/#{params[:slug]}/edit"
          end
        end # end shop fields empty conditional


      ## Build Tea from input
        # Create Tea if parameters exist
        if !params[:tea]["name"].empty?
          # Give error message if category or description are empty
          if params[:tea]["category"].empty? || params[:tea]["description"].empty?
            flash[:message] = ["New Tea fields are missing data. Please submit again."]
            flash[:type] = "error"
            redirect "/notes/#{params[:slug]}/edit"
          else
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
            else
              if tea.errors.any?
                flash[:message] = tea.errors.full_messages
                error_section = "New Tea Error"
                flash[:message].unshift(error_section)
                flash[:type] = "error"
              end
              redirect "/notes/#{params[:slug]}/edit"
            end     
          end
        end # end tea fields empty conditional

      # Set message and redirect
      if note.errors.any?
        flash[:message] = note.errors.full_messages
        error_section = "Note Error"
        flash[:message].unshift(error_section)        
        flash[:type] = "error"  
        redirect "/notes/#{params[:slug]}/edit"
      else
        tea.notes << note if tea
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
