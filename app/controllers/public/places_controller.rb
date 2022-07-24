class Public::PlacesController < ApplicationController
  before_action :search

  def new
    @place = Place.new
  end

  def confirm
    @place = Place.new(place_params)
    render :new if @place.invalid?
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
    @place_genres = PlaceGenre.all
    @q = Place.ransack(params[:q])
    # search addredd or introduction or user_name
    place_query_result = @q.result(distinct: true)
    # search prefecture ex: prefecture like %hokkaido%
    prefecture_query_result = Place.where(prefecture: params.dig(:q, :address_or_introduction_or_user_name_cont))
    if place_query_result == []
      @search_places = prefecture_query_result.order(id: "DESC").page(params[:page])
    elsif prefecture_query_result == []
      @search_places = place_query_result.order(id: "DESC").page(params[:page])
    else
      @search_places = place_query_result.or(prefecture_query_result).order(id: "DESC").uniq.page(params[:page])
    end
  end

  def index
    @places = Place.order(id: "DESC").page(params[:page])
    @place_genres = PlaceGenre.all
    @tags = Tag.all
  end

  def like_rank
    @like_ranks = Place.find(Like.group(:place_id).order('count(place_id) desc').pluck(:place_id))
    @like_ranks = Kaminari.paginate_array(@like_ranks).page(params[:page]).per(5)
    @place_genres = PlaceGenre.all
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
      flash.now[:alert] = '※すべての項目を埋めてください'
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
