class SongsController < ApplicationController

  configure do
    set :views, 'app/views'
  end
  
  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  post '/songs' do
    if params[:song][:artist_id]
      @song = Song.create(params[:song])
    elsif @artist = Artist.find_by_name(params[:artist][:name])
      @song = Song.create(params[:song])
      @artist.songs << @song
    else
      @artist = Artist.create(params[:artist])
      @song = Song.create(params[:song])
      @artist.songs << @song
    end
    if !params[:genre][:name].empty?
      @genre = Genre.create(params[:genre])
      @song.genres << @genre
    end
    @song.save
    session[:success_message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
    erb :'songs/new'
  end

  get '/songs/:slug' do
    set_song
    load_message 
    erb :'songs/show'
  end

  patch '/songs/:slug' do
    set_song
    @song.update(params[:song])
    if !params[:genre][:name].empty?
      @song.genres << Genre.create(params[:genre])
    end
    if !params[:artist][:name].empty?
      @song.artist = Artist.create(params[:artist])
      @song.save
    end
    session[:success_message] = "Successfully updated song."
    redirect "songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    set_song
    @genres = Genre.all
    @artists = Artist.all
    erb :'songs/edit'
  end
  
  private

  def set_song
    @song = Song.find_by_slug(params[:slug])
  end

  def load_message
    @message = session[:success_message]
    session[:success_message] = nil
  end

end
