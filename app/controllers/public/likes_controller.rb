class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    if @plan.user_id != current_user.id
      @like = Like.create(user_id: current_user.id, plan_id: @plan.id)
    end
    if @place.user_id != current_user.id
      @like = Like.create(user_id: current_user.id, place_id: @place.id)
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, plan_id: @plan.id)
    @like.destroy
  end


end
