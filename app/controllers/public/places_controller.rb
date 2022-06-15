class Public::PlacesController < ApplicationController
  before_action :search

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

  def search
    @q = Place.ransack(params[:q])
    selection = params[:keyword]
    @places = Place.sort(selection)
    @place_genres = PlaceGenre.all
  end

  def index
    @places = @q.result(distinct: true).order(id: "DESC")
    @place_genres = PlaceGenre.all
    @tags = Place.tag_counts_on(:tags)
    @all_ranks = Place.find(Like.group(:place_id).order('count(place_id) desc').limit(3).pluck(:place_id))
  end

  def show
    @place = Place.find(params[:id])
    @tags = Place.tag_counts_on(:tags)
  end

  def edit
    @place = Place.find(params[:id])
    if @place.user == current_user
      render :edit
    else
      redirect_to user_path(@place.user.id)
    end
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
    params.require(:place).permit(:address, :image, :image_cache, :time, :introduction, :tag_list, :place_genre_id, :latitude, :longitude)
  end

end
