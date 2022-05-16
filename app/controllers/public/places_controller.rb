class Public::PlacesController < ApplicationController
  def new
    @place = Place.new
  end

  def confirm
    @place = Place.new(place_params)
    @place.user_id = current_user.id
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    @place.save
    redirect_to places_path
  end

  def place_params
    params.require(:place).permit(:name, :image, :time, :introduction, :tag_list)
  end

end
