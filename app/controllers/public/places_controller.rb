class Public::PlacesController < ApplicationController
  def new
    @place = Place.new
  end

  def confirm
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    @places = Place.all
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    @place.save!
    redirect_to place_path(@place.id)
  end

  def index
    @places = Place.all
  end

  def show
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :image, :time, :introduction, :tag_list, :place_genre_id)
  end

end
