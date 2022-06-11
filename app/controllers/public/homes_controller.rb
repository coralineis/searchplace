class Public::HomesController < ApplicationController
  def top
    @place_genres = PlaceGenre.all
  end
end
