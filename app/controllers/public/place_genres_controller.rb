class Public::PlaceGenresController < ApplicationController
  def show
    @place_genre = PlaceGenre.find(params[:id])
  end
end
