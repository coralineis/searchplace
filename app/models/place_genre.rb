class PlaceGenre < ApplicationRecord
  has_many :places, dependent: :destroy

  enum genre_type: { place: 0, shop: 1 }
end
