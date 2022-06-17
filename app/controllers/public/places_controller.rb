class Public::PlacesController < ApplicationController
  before_action :search

  def new
    @place = Place.new
  end

  def confirm
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    tag_list = params[:place][:tag_name].split(/[[:blank:]]+/)
    @tag_list = Tag.all
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    tag_list = params[:place][:tag_name].split(/[[:blank:]]+/)
    if @place.save
      @place.save_tags(tag_list)
      redirect_to place_path(@place.id)
    else
      render :new
    end
  end

  def search
    selection = params[:keyword]
    @places = Place.sort(selection)
    @place_genres = PlaceGenre.all
  end

  def index
    @places = @q.result(distinct: true).order(id: "DESC")
    @place_genres = PlaceGenre.all
    @all_ranks = Place.find(Like.group(:place_id).order('count(place_id) desc').limit(3).pluck(:place_id))
    @tag_list = Tag.all
  end

  def show
    @place = Place.find(params[:id])
    @place_tags = @place.tags
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
    if @place.update(place_params)
      @place.save_tags(params[:place][:tags])
      redirect_to place_path(@place.id)
    else
      render :edit
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to my_page_path(current_user)
  end

  private

  def place_params
    params.require(:place).permit(:address, :prefecture, :image, :image_cache, :time, :introduction, :place_genre_id, :latitude, :longitude, tags: [:tag_name])
  end

end
