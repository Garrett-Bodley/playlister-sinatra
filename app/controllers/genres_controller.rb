class GenresController < ApplicationController

  get '/genres' do
    @genres = Genre.all
    erb :'/genres/index' 
  end

  get '/genres/new' do
    erb :'/genres/new'
  end

  get '/genres/:slug' do
    set_genre
    erb :'/genres/show'
  end

  get '/genres/:slug/edit' do
    set_genre
    erb :'/genres/edit'
  end

  def set_genre
    @genre = Genre.find_by_slug(params[:slug])
  end

end
