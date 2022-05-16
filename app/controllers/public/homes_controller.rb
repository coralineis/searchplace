class Public::HomesController < ApplicationController
  def top
    @plans = Plan.all
    @places = Place.all
    @search = Plan.ransack(params[:q])
  end
end
