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
    @place.save
    redirect_to place_path(@place.id)
  end

  def index
    @places = Place.all.order(id: "DESC")
    @tags = Place.tag_counts_on(:tags)
  end

  def show
    @place = Place.find(params[:id])
    @tags = Place.tag_counts_on(:tags)
  end

  private

  def place_params
    params.require(:place).permit(:name, :image, :image_cache, :time, :introduction, :tag_list, :place_genre_id)
  end

end
