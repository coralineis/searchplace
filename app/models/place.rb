class Place < ApplicationRecord
  belongs_to :user
  belongs_to :like
  belongs_to :review
  belongs_to :place_genre
end
