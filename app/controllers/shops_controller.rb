# Control shop pages
class ShopsController < ApplicationController

  # Display shop show page
  get '/shops/:slug' do
    @shop = Shop.find_by_slug(params[:slug])
    erb :'shop/show'
  end


end
