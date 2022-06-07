class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:plan_id]
      plan = Plan.find(params[:plan_id])
      like = current_user.likes.new(plan_id: plan.id)
      like.save
      redirect_to plan_path(plan)
    else
      place = Place.find(params[:place_id])
      like = current_user.likes.new(place_id: place.id)
      like.save
      redirect_to place_path(place)
    end
  end

  def destroy
    plan = Plan.find(params[:plan_id])
    like = current_user.likes.find_by(plan_id: plan.id)
    like.destroy
    redirect_to plan_path(plan)
    place = Place.find(params[:place_id])
    like = current_user.likes.find_by(place_id: place.id)
    like.destroy
    redirect_to place_path(place)
  end

end
