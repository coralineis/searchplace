class Public::HomesController < ApplicationController
  def top
    @plans = @q.result(distinct: true).order(id: "DESC")
    @place_genres = PlaceGenre.all
  end
end
