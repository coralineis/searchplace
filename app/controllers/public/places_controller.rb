class Public::PlacesController < ApplicationController
  before_action :search

  def new
    @place = Place.new
    @place.build_spot
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

  def search
    @q = Place.ransack(params[:q])
  end

  def index
    @places = @q.result(distinct: true).order(id: "DESC")
    @place_genres = PlaceGenre.all
    @tags = Place.tag_counts_on(:tags)
  end

  def show
    @place = Place.find(params[:id])
    @tags = Place.tag_counts_on(:tags)
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    @place.update(place_params)
    redirect_to place_path(@place.id)
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to my_page_path(current_user)
  end

  private

  def place_params
    params.require(:place).permit(:name, :image, :image_cache, :time, :introduction, :tag_list, :place_genre_id, spot_attributes:[:id, :address, :latitude, :longitude]).merge(user_id: current_user.id)
  end

end
