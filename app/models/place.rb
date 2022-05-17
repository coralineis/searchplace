class Place < ApplicationRecord
  attachment :image
  acts_as_taggable

  belongs_to :user
  belongs_to :place_genre
  has_many :likes, dependent: :destroy
end
