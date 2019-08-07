# Control notes pages
class NotesController < ApplicationController

  # Display user show page
  get '/notes/:slug' do
    @note = Note.find_by_slug(params[:slug])
    erb :'note/show'
  end

end
