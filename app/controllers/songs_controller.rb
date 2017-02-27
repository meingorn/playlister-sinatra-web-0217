class SongsController < ApplicationController
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods


  get '/songs' do
    erb :"songs/index"
  end

  get '/songs/new' do
    erb :"songs/new"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end

  def slug_temp(str)
    str.downcase.gsub(" ", '-')
  end

  post '/songs' do
    artist_id = nil
    if artist = Artist.all.find {|artist| artist.slug == slug_temp(params["Artist Name"]) }
      artist_id = artist.id
    else
      artist_id = Artist.create(name: params["Artist Name"]).id
    end

    new_params = {:name => params["Name"], :artist_id => artist_id}

    new_song = Song.create(name: params["Name"], artist_id: artist_id)

    params["genres"].each do |genre_id_str|
      genre_id = genre_id_str.to_i
      new_song.genres << Genre.find(genre_id)
    end

    new_song.save
    redirect to :"/songs/#{new_song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/edit"
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.artist = Aritst.find_or_create_by(name: params["Artist Name"])
    @song.save
    redirect to :"songs/#{@song.slug}"
  end

end
