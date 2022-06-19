class Public::PlacesController < ApplicationController
  def new
    @place = Place.new
  end

  def confirm
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    @tags = []
    params[:place][:tag].split(/[[:blank:]]+/).each do|t|
      @tags.push(Tag.new(name: t))
    end
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    if @place.save
      @place.save_tags(params[:tag])
      redirect_to place_path(@place.id)
    else
      flash.now[:alert] = '※すべての項目を埋めてください'
      render :new
    end
  end

  def search
    selection = params[:keyword]
    @places = Place.sort(selection)
    @search_places = @q.result
    @place_genres = PlaceGenre.all
  end

  def index
    @places = Place.order(id: "DESC").page(params[:page])
    @place_genres = PlaceGenre.all
    @tags = Tag.all
  end

  def show
    @place = Place.find(params[:id])
    @places = Place.all
    @tags = @place.tags
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
      @place.save_tags(params[:place][:tag])
      redirect_to user_path(@place.user.id)
    else
      render :edit
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to user_path(@place.user.id)
  end

  private

  def place_params
    params.require(:place).permit(:address, :prefecture, :image, :image_cache, :time, :introduction, :place_genre_id, :latitude, :longitude)
  end

end
