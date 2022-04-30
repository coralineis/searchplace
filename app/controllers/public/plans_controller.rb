class Public::PlansController < ApplicationController
  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.save
    redirect_to plan_path(@plan.id)
  end
  
  def index
    @plans = Plan.all
    @tags = Plan.tag_count_on()

  def show
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :place_name, :image, :time, :stay_night, :introduction, :tag)
  end
end
