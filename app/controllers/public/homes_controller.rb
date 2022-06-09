class Public::HomesController < ApplicationController
  before_action :search

  def search
    @q = Plan.ransack(params[:q])
  end

  def top
    @plans = @q.result(distinct: true)
  end
end
