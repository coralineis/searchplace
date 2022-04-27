class PlaceGenre < ApplicationRecord
  has_many :places, dependent: :destroy
end
