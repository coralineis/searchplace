class Public::PlacesController < ApplicationController
  def new
    @place = Place.new
  end

end
