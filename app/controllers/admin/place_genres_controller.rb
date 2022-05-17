class Admin::PlaceGenresController < ApplicationController
  def index
    @place_genre = PlaceGenre.new
    @place_genres = PlaceGenre.all
  end

  def create
    @place_genre = PlaceGenre.new(place_genre_params)
    @place_genre.save
    redirect_to admin_place_genres_path
  end

  def edit
    @place_genre = PlaceGenre.find(params[:id])
  end

  def update
    @place_genre = PlaceGenre.find(params[:id])
    @place_genre.update
    redirect_to admin_place_genres_path
  end

  def destroy
    @place_genre = PlaceGenre.find(params[:id])
    @place_genre.destroy
    redirect_to admin_place_genres_path
  end

  private

  def place_genre_params
    params.require(:place_genre).permit(:name)
  end
end
