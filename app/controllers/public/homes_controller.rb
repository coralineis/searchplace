class Public::HomesController < ApplicationController
  def top
    @plans = Plan.all
  end
end
