class ArtistsController < ApplicationController
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods


  get '/artists' do
    erb :"artists/index"
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :"artists/show"
  end

end
