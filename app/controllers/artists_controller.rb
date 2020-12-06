class ArtistsController < ApplicationController

  get '/artists' do
    @artists = Artist.all
    erb :'/artists/index' 
  end

  get '/artists/new' do
    erb :'/artists/new'
  end

  get '/artists/:slug' do
    set_artist
    erb :'/artists/show'
  end

  get '/artists/:slug/edit' do
    set_artist
    erb :'/artists/edit'
  end

  def set_artist
    @artist = Artist.find_by_slug(params[:slug])
  end

end
