class Public::PlaceGenresController < ApplicationController
  def show
    @place_genre = PlaceGenre.find(params[:id])
    @place_genres = PlaceGenre.all
  end
end
