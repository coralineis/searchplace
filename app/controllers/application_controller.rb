class ApplicationController < ActionController::Base
  before_action :authenticate_any!, except: [:top, :about, :index]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def authenticate_any!
    if admin_signed_in?
      true
    else
      authenticate_user!
    end
  end

  def set_search
    @q = Place.ransack(params[:q])
    # search addredd or introduction or user_name
    place_query_result = @q.result(distinct: true)
    # search prefecture ex: prefecture like %hokkaido%
    prefecture_query_result = Place.where(prefecture: params.dig(:q, :address_or_introduction_or_user_name_cont))
    # hint for like search
    # prefecture_query_result = Place.where('prefecture like ?', "%#{params.dig(:q, :address_or_introduction_or_user_name_cont)}%")
    if place_query_result == []
      @search_places = prefecture_query_result.order(id: "DESC").page(params[:page])
    elsif prefecture_query_result == []
      @search_places = place_query_result.order(id: "DESC").page(params[:page])
    else
      @search_places = place_query_result.or(prefecture_query_result).order(id: "DESC").uniq.page(params[:page])
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :prefecture, :is_deleted])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :prefecture, :is_deleted])
  end

end
