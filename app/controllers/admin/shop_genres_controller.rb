class Admin::ShopGenresController < ApplicationController
  def create
    @shop_genre = ShopGenre.new(shop_genre_params)
    @shop_genre.save
    redirect_to admin_place_genres_path
  end

  private

  def shop_genre_params
    params.require(:shop_genre).permit(:name)
  end
end
