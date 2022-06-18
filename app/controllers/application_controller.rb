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
    @search_places = @q.result(distinct: true).order(id: "DESC").page(params[:page])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :prefecture, :is_deleted])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :prefecture, :is_deleted])
  end

  private

end
