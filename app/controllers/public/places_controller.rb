class Public::PlacesController < ApplicationController
  def new
    @place = Place.new
  end
  
  def confirm
    @place = Place.new(place_params)
  end

  def create
    @place = Place.new(place_params)
    @place.save
    redirect_to place_path(@place.id)
  end

  def place_params
    params.require(:place).permit(:name, :image, :time, :introduction, :tag_list)
  end

end
