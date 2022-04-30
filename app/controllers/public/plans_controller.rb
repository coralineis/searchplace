class Public::PlansController < ApplicationController
  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.save
    redirect_to plan_path(@plan.id)
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :image_id, :time, :stay_night, :introduction, :tag)
  end
end
