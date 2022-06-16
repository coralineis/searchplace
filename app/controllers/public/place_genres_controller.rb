class Public::PlaceGenresController < ApplicationController
  before_action :search

  def show
    @place_genre = PlaceGenre.find(params[:id])
    @place_genres = PlaceGenre.all
  end

  def search
    @q = Place.ransack(params[:q])
    selection = params[:keyword]
    @places = Place.sort(selection)
    @place_genres = PlaceGenre.all
  end
end
