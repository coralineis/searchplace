class Public::HomesController < ApplicationController
  def top
    @plans = Plan.all
    @places = Place.all
  end
end
