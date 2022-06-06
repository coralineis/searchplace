class Public::PlansController < ApplicationController
  def new
    @plan = Plan.new
  end

  def confirm
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    @plan.save!
    if params[:back] || !@plan.save
      render :new and return
    end
    redirect_to plan_path(@plan.id)
  end

  def index
    @plans = Plan.all
    @tags = Plan.tag_counts_on(:tags)
  end

  def show
    @plan = Plan.find(params[:id])
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :place_name, :image, :image_cache, :time, :stay_night, :introduction, :tag_list)
  end
end
