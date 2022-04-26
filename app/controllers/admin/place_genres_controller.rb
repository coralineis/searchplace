class Admin::PlaceGenresController < ApplicationController
  def index
    @place_genre = PlaceGenre.new
  end
end
