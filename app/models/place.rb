class Place < ApplicationRecord
  attachment :image
  acts_as_taggable

  belongs_to :user
  belongs_to :like
  belongs_to :review
  belongs_to :place_genre
end
